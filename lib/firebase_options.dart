// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCAg98mHtU_tVpkZFTzJNkoEd1gPBgkeew',
    appId: '1:986338689170:web:6cd74c168758c10164a64b',
    messagingSenderId: '986338689170',
    projectId: 'importlookup',
    authDomain: 'importlookup.firebaseapp.com'
    // storageBucket: 'importlookup.appspot.com',
    // measurementId: 'G-4KS26HTW2H',


    //
    // apiKey: "AIzaSyDFtsZIVS4asgY3SfQmuWPRRoDCUNS_EUA",
    //         appId: "1:161776174529:web:4e51a68603beacf1425b40",
    //         messagingSenderId: "161776174529",
    //         storageBucket: "major-lms.appspot.com",
    //         projectId: "major-lms"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqcXuYCDrOneMc8mGHH6W2t0VZ7bAtcDs',
    appId: '1:986338689170:android:88ca8d29a075378a64a64b',
    messagingSenderId: '986338689170',
    projectId: 'importlookup',
    storageBucket: 'importlookup.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB03Fji44pwyMf5OGrL9rXusuD2C99sg0M',
    appId: '1:986338689170:ios:27868d49437cf51364a64b',
    messagingSenderId: '986338689170',
    projectId: 'importlookup',
    storageBucket: 'importlookup.appspot.com',
    iosBundleId: 'com.example.importLookup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB03Fji44pwyMf5OGrL9rXusuD2C99sg0M',
    appId: '1:986338689170:ios:27868d49437cf51364a64b',
    messagingSenderId: '986338689170',
    projectId: 'importlookup',
    storageBucket: 'importlookup.appspot.com',
    iosBundleId: 'com.example.importLookup',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCAg98mHtU_tVpkZFTzJNkoEd1gPBgkeew',
    appId: '1:986338689170:web:e3f34ae37511238964a64b',
    messagingSenderId: '986338689170',
    projectId: 'importlookup',
    authDomain: 'importlookup.firebaseapp.com',
    storageBucket: 'importlookup.appspot.com',
    measurementId: 'G-8KW4GMY9K7',
  );
}
