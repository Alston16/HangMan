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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD802AvuyUfyCQ1Hhs-mfmnJweJtqTO1Qs',
    appId: '1:653772397458:web:685afe909470547e1f7f4b',
    messagingSenderId: '653772397458',
    projectId: 'hangman-fc42b',
    authDomain: 'hangman-fc42b.firebaseapp.com',
    storageBucket: 'hangman-fc42b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfjNEUmTNE0azd9rqCD459t6wxFr9Eoj4',
    appId: '1:653772397458:android:0a2c1b51d86c92cc1f7f4b',
    messagingSenderId: '653772397458',
    projectId: 'hangman-fc42b',
    storageBucket: 'hangman-fc42b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVQPvf0mN1COmcbUGPxJ-ApFr9Ln7ihoU',
    appId: '1:653772397458:ios:ee2d72ecc7f827011f7f4b',
    messagingSenderId: '653772397458',
    projectId: 'hangman-fc42b',
    storageBucket: 'hangman-fc42b.appspot.com',
    iosBundleId: 'com.example.hangman',
  );
}
