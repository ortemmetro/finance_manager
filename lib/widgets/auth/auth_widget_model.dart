import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/domain/data_provider/box_manager/box_manager.dart';
import 'package:finance_manager/domain/entity/my_user.dart';
import 'package:finance_manager/domain/entity/my_user_for_hive.dart';
import 'package:finance_manager/session/session_id_manager.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_model.dart';
import 'package:finance_manager/widgets/settings_widgets/currency/currency_widget_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetModel extends ChangeNotifier {
  bool isButtonEnabled = true;

  Future<void> signIn(
    String email,
    String password,
    BuildContext context,
    CurrencyModel currencyModel,
  ) async {
    isButtonEnabled = !isButtonEnabled;
    notifyListeners();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      await SessionIdManager.instance
          .writeUserId(FirebaseAuth.instance.currentUser!.uid);
      final userId = await SessionIdManager.instance.readUserId();
      final docUsersReference = (await FirebaseFirestore.instance
              .collection('Users')
              .where('id', isEqualTo: userId)
              .get())
          .docs
          .first
          .reference;
      final userInfoObject = await docUsersReference.get();
      final userInfoMap = userInfoObject.data();
      final userInfo = MyUser.fromJson(userInfoMap!);
      final userForHive = MyUserForHive(
        id: userInfo.id,
        firstName: userInfo.firstName,
        lastName: userInfo.lastName,
        age: userInfo.age,
        currency: userInfo.currency,
        locale: userInfo.locale,
        accounts: userInfo.accounts,
      );

      final userBox = await BoxManager.instance.openUserBox();
      final usersList = userBox.values.toList();

      if (usersList.where((element) => element.id == userForHive.id).isEmpty) {
        final userKey = await userBox.add(userForHive);
        await SessionIdManager.instance.writeUserKey(userKey);
      } else {
        await SessionIdManager.instance.writeUserKey(
          usersList.firstWhere((element) => element.id == userForHive.id).key,
        );
      }

      if (userBox.isOpen) {
        await BoxManager.instance.closeBox(userBox);
      }

      final addCategoryModel =
          Provider.of<AddCategoryModel>(context, listen: false);
      await addCategoryModel.downloadCategoriesFromHive();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
