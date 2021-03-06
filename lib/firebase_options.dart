// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyApLOlh1RrB4YQ1cw3jo8F89cuYP79yeVw',
    appId: '1:49047118517:web:1aa4d9079379786a9994fc',
    messagingSenderId: '49047118517',
    projectId: 'finder-login-application',
    authDomain: 'finder-login-application.firebaseapp.com',
    storageBucket: 'finder-login-application.appspot.com',
    measurementId: 'G-5LWF3KGQB7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChxsbx9BcsAFNF_9nL2d2ggg1q4YZqcss',
    appId: '1:49047118517:android:bacb0710dc0417e99994fc',
    messagingSenderId: '49047118517',
    projectId: 'finder-login-application',
    storageBucket: 'finder-login-application.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDR9HbN3e-MWLSUMArAeV8TFBhk-DSGsuE',
    appId: '1:49047118517:ios:eb01d8e3e3f97cef9994fc',
    messagingSenderId: '49047118517',
    projectId: 'finder-login-application',
    storageBucket: 'finder-login-application.appspot.com',
    androidClientId:
        '49047118517-m24lpbqkal02lqlsu8c9653v2osf0osh.apps.googleusercontent.com',
    iosClientId:
        '49047118517-3ff28vs3cbs2nrsad2o73qd45bi6l7g3.apps.googleusercontent.com',
    iosBundleId: 'web',
  );
}
