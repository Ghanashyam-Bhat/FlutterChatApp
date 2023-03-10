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
    apiKey: 'AIzaSyB97aw7aQW2VJHEalvzZTkObDpdSIPbXyc',
    appId: '1:402925468401:web:ee4af24836249280644750',
    messagingSenderId: '402925468401',
    projectId: 'intecc-app-demo',
    authDomain: 'intecc-app-demo.firebaseapp.com',
    storageBucket: 'intecc-app-demo.appspot.com',
    measurementId: 'G-XWPLK7D93W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUpCXIK622BNungfoKuxkqWKYvnWDQf9w',
    appId: '1:402925468401:android:6a02edac44e8578c644750',
    messagingSenderId: '402925468401',
    projectId: 'intecc-app-demo',
    storageBucket: 'intecc-app-demo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAya1Yij71vivboEmUi5aiYR7pY9rKGPlk',
    appId: '1:402925468401:ios:176053ed853298b0644750',
    messagingSenderId: '402925468401',
    projectId: 'intecc-app-demo',
    storageBucket: 'intecc-app-demo.appspot.com',
    iosClientId: '402925468401-itvksj3iutoj2cdm28kaji18n33041o7.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
