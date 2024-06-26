import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/domain/data_provider/box_manager/box_manager.dart';
import 'package:finance_manager/domain/entity/my_user.dart';
import 'package:finance_manager/domain/entity/my_user_for_hive.dart';
import 'package:finance_manager/src/core/session/session_id_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpWidgetModel extends ChangeNotifier {
  String notValidPasswordString = '';

  bool isButtonEnabled = true;

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required int age,
    required String currency,
    required BuildContext context,
  }) async {
    isButtonEnabled = !isButtonEnabled;
    final mainAccountName = AppLocalizations.of(context)!.mainAccount;
    notifyListeners();
    if (password != confirmPassword) {
      notValidPasswordString = 'Пароли не идентичны! Попробуйте ещё раз';
      notifyListeners();
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _addUserDetails(
        firstName,
        lastName,
        email,
        age,
        currency,
        mainAccountName,
      );

      final userForHive = MyUserForHive(
        id: FirebaseAuth.instance.currentUser!.uid,
        firstName: firstName,
        lastName: lastName,
        age: age,
        currency: currency,
        locale: Platform.localeName.substring(0, 2),
        accounts: [mainAccountName],
      );

      final userBox = await BoxManager.instance.openUserBox();

      if (!userBox.values.contains(userForHive)) {
        final userKey = await userBox.add(userForHive);
        await SessionIdManager.instance.writeUserKey(userKey);
      }

      await BoxManager.instance.closeBox(userBox);

      await SessionIdManager.instance
          .writeUserId(FirebaseAuth.instance.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void resetErrorText() {
    notValidPasswordString = '';
    notifyListeners();
  }

  Future<void> _addUserDetails(
    String firstName,
    String lastName,
    String email,
    int age,
    String currency,
    String mainAccountName,
  ) async {
    final usersDocReference =
        FirebaseFirestore.instance.collection('Users').doc();
    final user = MyUser(
      id: FirebaseAuth.instance.currentUser!.uid,
      firstName: firstName,
      lastName: lastName,
      age: age,
      currency: currency,
      locale: Platform.localeName.substring(0, 2),
      accounts: [mainAccountName],
      expenses: null,
      ownCategories: null,
    );

    final json = user.toJson();

    await usersDocReference.set(json);
  }
}
