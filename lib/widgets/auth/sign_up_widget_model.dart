// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
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
    await FirebaseFirestore.instance.collection("Users").add({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
    });
  }
}
