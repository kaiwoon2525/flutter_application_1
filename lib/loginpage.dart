import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/signuppage.dart';
import 'package:flutter_application_1/uihelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> storeLoggedInState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', value);
  }

  Future<bool> getLoggedInState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }

  login(String email, String password) async {
    if (email == '' && password == '') {
      return UiHelper.customAlerBox(context, 'Enter Required Fields');
    } else {
      try {
        // Initiate OAuth flow here to obtain access tokens
        // Example: You might use FirebaseAuth for OAuth authentication
        // Replace this with your actual OAuth authentication method
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // Store login state
        await storeLoggedInState(true);

        // Navigate to home screen upon successful login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } on FirebaseAuthException catch (ex) {
        // Handle authentication errors
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

  @override
  void initState() {
    super.initState();
    checkLoggedInState();
  }

  void checkLoggedInState() async {
    bool isLoggedIn = await getLoggedInState();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
