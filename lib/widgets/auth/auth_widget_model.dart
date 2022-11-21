import 'package:finance_manager/session/session_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWidgetModel {
  Future signIn(String email, String password, BuildContext context) async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => Center(child: CircularProgressIndicator()),
    // );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      SessionKey.currentUserId = FirebaseAuth.instance.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
