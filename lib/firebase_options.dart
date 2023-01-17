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
    apiKey: 'AIzaSyBz95Wmr5WX40Oyqw7ZgiXihEBuuhzP03U',
    appId: '1:638477807526:web:94362092ea50ef8aefa967',
    messagingSenderId: '638477807526',
    projectId: 'ditonton-zan',
    authDomain: 'ditonton-zan.firebaseapp.com',
    storageBucket: 'ditonton-zan.appspot.com',
    measurementId: 'G-RVCH763CJ3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAiua1qxdLdPgdgDDvrJG9U_wCnrJtVqyw',
    appId: '1:638477807526:android:ff63c8c687a730e3efa967',
    messagingSenderId: '638477807526',
    projectId: 'ditonton-zan',
    storageBucket: 'ditonton-zan.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOJp1wciWuH87TqUJ6UUEjR4x90A3tcm4',
    appId: '1:638477807526:ios:466a62048ed7ed83efa967',
    messagingSenderId: '638477807526',
    projectId: 'ditonton-zan',
    storageBucket: 'ditonton-zan.appspot.com',
    iosClientId: '638477807526-3vo5ghshqq45sv1gri31osrcacnrbq7h.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}
