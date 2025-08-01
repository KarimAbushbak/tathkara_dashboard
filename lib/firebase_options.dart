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
    apiKey: 'AIzaSyD0LoZwHLYYQ0BXHK1_sm21ctcTDDJCSXE',
    appId: '1:507573897639:web:7cc644fdd6dd1279054e82',
    messagingSenderId: '507573897639',
    projectId: 'notifactiontest-ea12b',
    authDomain: 'notifactiontest-ea12b.firebaseapp.com',
    storageBucket: 'notifactiontest-ea12b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzBEYIuSWhnC9yRWobBemzs2w8DaNOEz0',
    appId: '1:507573897639:android:969c922bcfa47921054e82',
    messagingSenderId: '507573897639',
    projectId: 'notifactiontest-ea12b',
    storageBucket: 'notifactiontest-ea12b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4Cgp4VUFLgz45TnJnrvYFOCsEgKvbmQo',
    appId: '1:507573897639:ios:e5ccc6ed2f0a2aed054e82',
    messagingSenderId: '507573897639',
    projectId: 'notifactiontest-ea12b',
    storageBucket: 'notifactiontest-ea12b.firebasestorage.app',
    iosBundleId: 'com.example.tathkaraDashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4Cgp4VUFLgz45TnJnrvYFOCsEgKvbmQo',
    appId: '1:507573897639:ios:e5ccc6ed2f0a2aed054e82',
    messagingSenderId: '507573897639',
    projectId: 'notifactiontest-ea12b',
    storageBucket: 'notifactiontest-ea12b.firebasestorage.app',
    iosBundleId: 'com.example.tathkaraDashboard',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD0LoZwHLYYQ0BXHK1_sm21ctcTDDJCSXE',
    appId: '1:507573897639:web:577f1c1a24f53e15054e82',
    messagingSenderId: '507573897639',
    projectId: 'notifactiontest-ea12b',
    authDomain: 'notifactiontest-ea12b.firebaseapp.com',
    storageBucket: 'notifactiontest-ea12b.firebasestorage.app',
  );
}
