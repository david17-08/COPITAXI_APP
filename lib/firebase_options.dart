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
    apiKey: 'AIzaSyCV3QOFYx3tzT2l1I7c51ekmCZMIUhpwsQ',
    appId: '1:213326261794:web:2e054c513ac3541e13247b',
    messagingSenderId: '213326261794',
    projectId: 'copitaxi-93622',
    authDomain: 'copitaxi-93622.firebaseapp.com',
    storageBucket: 'copitaxi-93622.firebasestorage.app',
    measurementId: 'G-XCFBF5S4BF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0sIn2YMY1g9Dof_Y_suyuTCT-1GHvU8k',
    appId: '1:213326261794:android:adfe26f2911915f213247b',
    messagingSenderId: '213326261794',
    projectId: 'copitaxi-93622',
    storageBucket: 'copitaxi-93622.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeDNf0HmrC-YG-dWcEZHphVI4l3FbPnR4',
    appId: '1:213326261794:ios:03556ee403c66bcd13247b',
    messagingSenderId: '213326261794',
    projectId: 'copitaxi-93622',
    storageBucket: 'copitaxi-93622.firebasestorage.app',
    iosClientId: '213326261794-8oiapl90bg4qp1ffffp2c1pc6ekodv79.apps.googleusercontent.com',
    iosBundleId: 'com.example.copitaxiApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeDNf0HmrC-YG-dWcEZHphVI4l3FbPnR4',
    appId: '1:213326261794:ios:03556ee403c66bcd13247b',
    messagingSenderId: '213326261794',
    projectId: 'copitaxi-93622',
    storageBucket: 'copitaxi-93622.firebasestorage.app',
    iosClientId: '213326261794-8oiapl90bg4qp1ffffp2c1pc6ekodv79.apps.googleusercontent.com',
    iosBundleId: 'com.example.copitaxiApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCV3QOFYx3tzT2l1I7c51ekmCZMIUhpwsQ',
    appId: '1:213326261794:web:6e323ac2a67c20e913247b',
    messagingSenderId: '213326261794',
    projectId: 'copitaxi-93622',
    authDomain: 'copitaxi-93622.firebaseapp.com',
    storageBucket: 'copitaxi-93622.firebasestorage.app',
    measurementId: 'G-XEKW0L146Z',
  );

}