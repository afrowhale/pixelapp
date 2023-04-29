import 'package:flutter/material.dart';
import 'pixel_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!,
    databaseURL: dotenv.env['FIREBASE_DATABASE_URL']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
    measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID']!,
  );

  await Firebase.initializeApp(options: firebaseOptions);

  runApp(
    const MaterialApp(
      home: PixelApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
