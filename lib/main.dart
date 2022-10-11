import 'package:final_project/Home.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    title: 'Zaad',
    home: Login(),
  ));
}
