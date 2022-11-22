// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/entity/myUser.dart';
import 'package:finance_manager/session/session_id_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      _addUserDetails(firstName, lastName, email, age);
      final sessionIdModel =
          Provider.of<SessionIdModel>(context, listen: false);
      await sessionIdModel.writeUserId(FirebaseAuth.instance.currentUser!.uid);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void resetErrorText() {
    notValidPasswordString = "";
    notifyListeners();
  }

  Future _addUserDetails(
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
      expenses: [],
    );

    final json = user.toJson();

    await usersDocReference.set(json);
  }
}
