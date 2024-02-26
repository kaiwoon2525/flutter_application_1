import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/colors.dart';
// ignore: unused_import
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutflix',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBgColor,
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
