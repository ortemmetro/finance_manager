import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/src/core/di/di.dart';
import 'package:finance_manager/src/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DataSourceModule {
  static Future<void> init() async {
    getIt.registerFactory<AuthenticationDataSource>(
      () => AuthenticationDataSource(
        getIt<FirebaseAuth>(),
        getIt<FirebaseFirestore>(),
      ),
    );
  }
}
