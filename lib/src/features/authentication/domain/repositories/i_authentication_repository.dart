import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationRepository {
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int age,
    required String currency,
  });

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
