import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/default_data/default_categories_data.dart';
import 'package:finance_manager/entity/category.dart';
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
      List<Category> tempList = [];
      await sessionIdModel.writeUserId(FirebaseAuth.instance.currentUser!.uid);
      final userId = await SessionIdModel().readUserId("uid");
      final userReference = (await FirebaseFirestore.instance
              .collection('Users')
              .where("id", isEqualTo: userId)
              .get())
          .docs
          .first
          .reference;
      final categoryReference = userReference.collection("Categories");
      if (categoryReference.doc().path.isNotEmpty) {
        tempList = await categoryReference
            .snapshots()
            .map((snapshot) => snapshot.docs
                .map((doc) => Category.fromJson(doc.data()))
                .toList())
            .first;
      }
      DefaultCategoriesData().listOfTempCategories = tempList;
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
