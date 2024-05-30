import 'dart:developer';

import 'package:finance_manager/src/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:finance_manager/src/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final AuthenticationDataSource _authenticationDataSource;

  AuthenticationRepository({
    required AuthenticationDataSource authenticationDataSource,
  }) : _authenticationDataSource = authenticationDataSource;

  @override
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int age,
    required String currency,
  }) async {
    try {
      return await _authenticationDataSource.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        age: age,
        currency: currency,
      );
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw FirebaseAuthException(code: e.code);
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirebaseException(
        plugin: 'Authentication',
        code: e.code,
      );
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _authenticationDataSource.signIn(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw FirebaseAuthException(code: e.code);
    } on FirebaseException catch (e) {
      log(e.toString());
      throw FirebaseException(
        plugin: 'Authentication',
        code: e.code,
      );
    }
  }
}
