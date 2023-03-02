import 'package:finance_manager/widgets/settings_widgets/categories/add_category_widget_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class AuthEvent {}

class SignIn extends AuthEvent {}

abstract class AuthState {}

// State when not authorized
class AuthUnauthorizedState extends AuthState {}

// State when authorized
class AuthAuthorizedState extends AuthState {}

// State when authorization failed
class AuthFailureState extends AuthState {
  final Object error;

  AuthFailureState(this.error);
}

// State when authorization in progress
class AuthInProgressState extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthState initialState) : super(initialState) {
    on<SignIn>((event, emit) {});
  }
}

class AuthWidgetModel {
  Future signIn(String email, String password, BuildContext context) async {
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
