import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goggles_of_revealing/controller/auth.dart';
import 'package:goggles_of_revealing/controller/store.dart';
import 'package:goggles_of_revealing/ui/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = "";
  bool isLogin = true;

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: controllerEmail.text, password: controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: controllerEmail.text, password: controllerPassword.text);
      Api().addUserToStore();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text("Login");
  }

  Widget entryField(
      String title, TextEditingController controller, bool isObscure) {
    return SizedBox(
        width: 250,
        child: TextField(
          obscureText: isObscure,
          controller: controller,
          decoration: InputDecoration(
              labelText: title, border: const OutlineInputBorder()),
        ));
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget submitButton() {
    return ElevatedButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: Constants.primaryColor),
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(isLogin ? "Login" : "Register"));
  }

  Widget loginOrRegisterButton() {
    return TextButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: Constants.primaryColor),
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(
          isLogin ? 'Register instead' : 'Login instead',
          style: const TextStyle(color: Colors.white),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            entryField('email', controllerEmail, false),
            const SizedBox(
              height: 20,
            ),
            entryField('password', controllerPassword, true),
            _errorMessage(),
            submitButton(),
            loginOrRegisterButton()
          ],
        ),
      ),
    );
  }
}
