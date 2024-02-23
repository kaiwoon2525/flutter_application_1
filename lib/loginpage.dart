import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/signuppage.dart';
import 'package:flutter_application_1/uihelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
    if (email == '' && password == '') {
      return UiHelper.customAlerBox(context, 'Enter Required Fields');
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
          (value) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        );
      } on FirebaseAuthException catch (ex) {
        return UiHelper.customAlerBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.customTextField(emailController, 'Email', Icons.mail, false),
          UiHelper.customTextField(
              passwordController, 'Password', Icons.password, true),
          const SizedBox(height: 30),
          UiHelper.customButton(() {
            login(emailController.text.toString(),
                passwordController.text.toString());
          }, 'Login'),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Already Have an Account??',
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text('Sign Up'),
                //style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,),
              )
            ],
          )
        ],
      ),
    );
  }
}
