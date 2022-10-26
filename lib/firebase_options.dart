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
    apiKey: 'AIzaSyDvMlRBTKfKBfuJJ4IegZeO5Q2yfURdeG0',
    appId: '1:234916072663:web:c3cc996de151948fef3492',
    messagingSenderId: '234916072663',
    projectId: 'authentication-databse',
    authDomain: 'authentication-databse.firebaseapp.com',
    storageBucket: 'authentication-databse.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCakOPvj_WRf3UFgifqlPMQhxBjV9KkvUQ',
    appId: '1:234916072663:android:b18f06141d77e989ef3492',
    messagingSenderId: '234916072663',
    projectId: 'authentication-databse',
    storageBucket: 'authentication-databse.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwb6GhHwEUUc99Di0IROS4fr65dn3ZvaU',
    appId: '1:234916072663:ios:2ed3c7bf83b48524ef3492',
    messagingSenderId: '234916072663',
    projectId: 'authentication-databse',
    storageBucket: 'authentication-databse.appspot.com',
    androidClientId: '234916072663-8sa7dgk9jf2boah8q2fk9k5rf5b5vbvc.apps.googleusercontent.com',
    iosClientId: '234916072663-0f2t707lmv5atjr5k6pu69q10krabfja.apps.googleusercontent.com',
    iosBundleId: 'com.example.sad',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwb6GhHwEUUc99Di0IROS4fr65dn3ZvaU',
    appId: '1:234916072663:ios:2ed3c7bf83b48524ef3492',
    messagingSenderId: '234916072663',
    projectId: 'authentication-databse',
    storageBucket: 'authentication-databse.appspot.com',
    androidClientId: '234916072663-8sa7dgk9jf2boah8q2fk9k5rf5b5vbvc.apps.googleusercontent.com',
    iosClientId: '234916072663-0f2t707lmv5atjr5k6pu69q10krabfja.apps.googleusercontent.com',
    iosBundleId: 'com.example.sad',
  );
}