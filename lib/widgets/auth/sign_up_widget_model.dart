// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpWidgetModel extends ChangeNotifier {
  String notValidPasswordString = "";

  Future signUp(String email, String password, String confirmPassword) async {
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
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void resetErrorText() {
    notValidPasswordString = "";
    notifyListeners();
  }
}
