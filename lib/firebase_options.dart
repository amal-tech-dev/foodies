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
    apiKey: 'AIzaSyBRFd-oLedEm4nvwHqz2TpQyLqgWtEQn4k',
    appId: '1:1080290120590:web:bd6c6fccec0daff8c40adf',
    messagingSenderId: '1080290120590',
    projectId: 'madroid-foodies',
    authDomain: 'madroid-foodies.firebaseapp.com',
    storageBucket: 'madroid-foodies.appspot.com',
    measurementId: 'G-Q50D89LG0C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAA8II8s3UZS7jt9-6KpjlHezADtzqK438',
    appId: '1:1080290120590:android:6433d6e1dca68160c40adf',
    messagingSenderId: '1080290120590',
    projectId: 'madroid-foodies',
    storageBucket: 'madroid-foodies.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPFM0mF2MQ7NPyBZj0PJGbNPVaXDZ5rUg',
    appId: '1:1080290120590:ios:27b2f0ffcbed1339c40adf',
    messagingSenderId: '1080290120590',
    projectId: 'madroid-foodies',
    storageBucket: 'madroid-foodies.appspot.com',
    iosBundleId: 'com.example.foodies',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPFM0mF2MQ7NPyBZj0PJGbNPVaXDZ5rUg',
    appId: '1:1080290120590:ios:2957c3a21246424fc40adf',
    messagingSenderId: '1080290120590',
    projectId: 'madroid-foodies',
    storageBucket: 'madroid-foodies.appspot.com',
    iosBundleId: 'com.example.foodies.RunnerTests',
  );
}
