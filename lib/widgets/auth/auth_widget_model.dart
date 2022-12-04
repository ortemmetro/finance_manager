import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
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
      final addCategoryModel =
          Provider.of<AddCategoryWidgetModel>(context, listen: false);
      await addCategoryModel.downloadCategories(context);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
