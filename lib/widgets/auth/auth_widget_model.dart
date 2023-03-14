import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/domain/data_provider/box_manager/box_manager.dart';
import 'package:finance_manager/domain/entity/my_user.dart';
import 'package:finance_manager/domain/entity/my_user_for_hive.dart';

import 'package:finance_manager/session/session_id_manager.dart';
import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// abstract class AuthEvent {}

// class SignIn extends AuthEvent {}

// abstract class AuthState {}

// // State when not authorized
// class AuthUnauthorizedState extends AuthState {}

// // State when authorized
// class AuthAuthorizedState extends AuthState {}

// // State when authorization failed
// class AuthFailureState extends AuthState {
//   final Object error;

//   AuthFailureState(this.error);
// }

// // State when authorization in progress
// class AuthInProgressState extends AuthState {}

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc(AuthState initialState) : super(initialState) {
//     on<SignIn>((event, emit) {});
//   }
// }

class AuthWidgetModel {
  Future signIn(String email, String password, BuildContext context) async {
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
              .where("id", isEqualTo: userId)
              .get())
          .docs
          .first
          .reference;
      final userInfoObject = await docUsersReference.get();
      final userInfoMap = userInfoObject.data();
      final userInfo = MyUser.fromJson(userInfoMap!);
      final userForHive = MyUserForHive(
        firstName: userInfo.firstName,
        lastName: userInfo.lastName,
        age: userInfo.age,
      );

      final userBox = await BoxManager.instance.openUserBox();

      if (!userBox.values.contains(userForHive)) {
        final userKey = await userBox.add(userForHive);
        await SessionIdManager.instance.writeUserKey(userKey);
      }

      await BoxManager.instance.closeBox(userBox);

      final addCategoryModel =
          Provider.of<AddCategoryWidgetModel>(context, listen: false);
      await addCategoryModel.downloadCategoriesFromHive();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
