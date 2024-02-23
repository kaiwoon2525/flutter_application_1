import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/loginpage.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/uihelper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUp(String email, String password) async {
    if (email == '' && password == '') {
      UiHelper.customAlerBox(context, 'Enter Required Fields');
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.customAlerBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up page'),
        centerTitle: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        UiHelper.customTextField(emailController, 'Email', Icons.mail, false),
        UiHelper.customTextField(
            passwordController, 'Password', Icons.password, true),
        SizedBox(height: 30),
        UiHelper.customButton(() {
          signUp(emailController.text.toString(),
              passwordController.text.toString());
        }, 'Sign Up'),
      ]),
    );
  }
}
