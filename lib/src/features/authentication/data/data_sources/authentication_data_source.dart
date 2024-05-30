import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/domain/entity/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  const AuthenticationDataSource(
    this._firebaseAuth,
    this._firebaseFirestore,
  );

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int age,
    required String currency,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    await _addUserDetailsToFirebaseFirestore(
      id: userCredential.user!.uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      age: age,
      currency: currency,
    );

    return userCredential;
  }

  Future<void> _addUserDetailsToFirebaseFirestore({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required int age,
    required String currency,
  }) async {
    final usersDocReference = _firebaseFirestore.collection('Users').doc();
    final user = AppUser(
      id: id,
      firstName: firstName,
      lastName: lastName,
      age: age,
      currency: currency,
      locale: Platform.localeName.substring(0, 2),
      expenses: null,
      ownCategories: null,
    );

    final json = user.toJson();

    await usersDocReference.set(json);
  }
}
