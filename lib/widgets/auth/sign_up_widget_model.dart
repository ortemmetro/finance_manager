import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/data_provider/box_manager/box_manager.dart';
import 'package:finance_manager/entity/my_user.dart';
import 'package:finance_manager/entity/my_user_for_hive.dart';
import 'package:finance_manager/session/session_id_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpWidgetModel extends ChangeNotifier {
  String notValidPasswordString = "";

  Future signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required int age,
    required BuildContext context,
  }) async {
    if (password != confirmPassword) {
      notValidPasswordString = "Пароли не идентичны! Попробуйте ещё раз";
      notifyListeners();
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await _addUserDetails(firstName, lastName, email, age);

      final userForHive = MyUserForHive(
        firstName: firstName,
        lastName: lastName,
        age: age,
      );

      final userBox = await BoxManager.instance.openUserBox();

      if (!userBox.values.contains(userForHive)) {
        final userKey = await userBox.add(userForHive);
        await SessionIdManager.instance.writeUserKey(userKey);
      }

      await BoxManager.instance.closeBox(userBox);

      await SessionIdManager.instance
          .writeUserId(FirebaseAuth.instance.currentUser!.uid);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void resetErrorText() {
    notValidPasswordString = "";
    notifyListeners();
  }

  Future<void> _addUserDetails(
    String firstName,
    String lastName,
    String email,
    int age,
  ) async {
    final usersDocReference =
        FirebaseFirestore.instance.collection("Users").doc();
    final user = MyUser(
      id: FirebaseAuth.instance.currentUser!.uid,
      firstName: firstName,
      lastName: lastName,
      age: age,
      expenses: null,
      ownCategories: null,
    );

    final json = user.toJson();

    await usersDocReference.set(json);
  }
}
