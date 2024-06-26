// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAQ2-Ns6-YsAS-_59PWlzcJW6PIjy8ExFQ',
    appId: '1:568187925020:web:7892f27423eb7246a765d9',
    messagingSenderId: '568187925020',
    projectId: 'finance-manager-205a2',
    authDomain: 'finance-manager-205a2.firebaseapp.com',
    storageBucket: 'finance-manager-205a2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTeWp5lPBeOpgP-yOSg98znCgb0jvc7_M',
    appId: '1:568187925020:android:16489a09088810d5a765d9',
    messagingSenderId: '568187925020',
    projectId: 'finance-manager-205a2',
    storageBucket: 'finance-manager-205a2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8FIZ49J0DEqQL4bS7cmdeHeUw4d9dTjg',
    appId: '1:568187925020:ios:59255484134be7bca765d9',
    messagingSenderId: '568187925020',
    projectId: 'finance-manager-205a2',
    storageBucket: 'finance-manager-205a2.appspot.com',
    iosBundleId: 'com.example.financeManager',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD8FIZ49J0DEqQL4bS7cmdeHeUw4d9dTjg',
    appId: '1:568187925020:ios:59255484134be7bca765d9',
    messagingSenderId: '568187925020',
    projectId: 'finance-manager-205a2',
    storageBucket: 'finance-manager-205a2.appspot.com',
    iosBundleId: 'com.example.financeManager',
  );
}
