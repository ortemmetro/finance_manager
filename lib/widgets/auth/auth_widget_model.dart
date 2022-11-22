import 'package:finance_manager/session/session_id_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      final sessionIdModel =
          Provider.of<SessionIdModel>(context, listen: false);
      await sessionIdModel.writeUserId(FirebaseAuth.instance.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
