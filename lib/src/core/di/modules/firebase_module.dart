import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/src/core/di/di.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseModule {
  static Future<void> init() async {
    getIt.registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
    );

    getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
  }
}
