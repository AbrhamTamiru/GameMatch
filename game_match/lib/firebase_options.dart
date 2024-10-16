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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJB6PuXfoq7QYPhLkiLBZOuTrhci2bRgI',
    appId: '1:861037100165:android:365827f585021fcc0c3dec',
    messagingSenderId: '861037100165',
    projectId: 'gamematch-e492c',
    storageBucket: 'gamematch-e492c.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB8MlrUKy9ec1l5i_iBzpBpwkqK6wo9Jy4',
    appId: '1:861037100165:web:88e54a510aae364b0c3dec',
    messagingSenderId: '861037100165',
    projectId: 'gamematch-e492c',
    authDomain: 'gamematch-e492c.firebaseapp.com',
    storageBucket: 'gamematch-e492c.appspot.com',
    measurementId: 'G-L69DEW9WGR',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDiVQZMPLHzFBDQI4n3-By3Cgioa8Rvi0w',
    appId: '1:861037100165:ios:bf21baebecf6487c0c3dec',
    messagingSenderId: '861037100165',
    projectId: 'gamematch-e492c',
    storageBucket: 'gamematch-e492c.appspot.com',
    iosBundleId: 'com.example.gameMatch',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiVQZMPLHzFBDQI4n3-By3Cgioa8Rvi0w',
    appId: '1:861037100165:ios:bf21baebecf6487c0c3dec',
    messagingSenderId: '861037100165',
    projectId: 'gamematch-e492c',
    storageBucket: 'gamematch-e492c.appspot.com',
    iosBundleId: 'com.example.gameMatch',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB8MlrUKy9ec1l5i_iBzpBpwkqK6wo9Jy4',
    appId: '1:861037100165:web:502c06a9367b38630c3dec',
    messagingSenderId: '861037100165',
    projectId: 'gamematch-e492c',
    authDomain: 'gamematch-e492c.firebaseapp.com',
    storageBucket: 'gamematch-e492c.appspot.com',
    measurementId: 'G-TT1Q593LPJ',
  );

}