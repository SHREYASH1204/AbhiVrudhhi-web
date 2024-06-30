import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHMHYow9ga0nd4dv3yqwt6hSlmFxU_Iwk',
    appId: '1:1084641002298:android:a8158bfc4814b210294603',
    messagingSenderId: '1084641002298',
    projectId: 'smartcity-706b3',
    storageBucket: 'smartcity-706b3.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBN50tGuBAmPSM_cVvEY6b_fBwUv8z3HP4',
    appId: '1:1084641002298:web:636754384ad22b7d294603',
    messagingSenderId: '1084641002298',
    projectId: 'smartcity-706b3',
    authDomain: 'smartcity-706b3.firebaseapp.com',
    storageBucket: 'smartcity-706b3.appspot.com',
    measurementId: 'G-540ZEPX57N',
  );
}
