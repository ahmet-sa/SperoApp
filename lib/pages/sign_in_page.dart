
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spero_app_/pages/landing_page.dart';

import '../widgets/buttons.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final String _email = "ahmeetsarioglu@gmail.com";
  final String _password = "123456";

  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spero APP"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            const SizedBox(height: 8),
            Button(
              buttonText: "Sign in With Google",
              butonColor: Colors.white,
              textColor: Colors.black87,
              radius: 16,
              height: 80,
              buttonIcon: Image.asset("images/google-logo.png"),
              onPress: () {},
            ),
            Button(
              buttonText: "Sign in With Facebook",
              butonColor: const Color(0xFF334D92),
              textColor: Colors.white,
              radius: 16,
              height: 80,
              buttonIcon: Image.asset("images/facebook-logo.png"),
              onPress: () {},
            ),
            Button(
              buttonText: "Sign in Email and Passward",
              butonColor: Colors.purple,
              textColor: Colors.white,
              radius: 16,
              height: 80,
              buttonIcon: const Icon(
                Icons.email,
                size: 28,
              ),
              onPress: () {
                
              },
            ),
            Button(
              buttonText: "guest entry",
              butonColor: Colors.orange,
              textColor: Colors.white,
              radius: 16,
              height: 80,
              buttonIcon: const Icon(
                Icons.supervised_user_circle,
                size: 28,
              ),
              onPress: () {
                _signInAnaymus();

              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInAnaymus() async {
    UserCredential userAnaymus = await auth.signInAnonymously();

    if (userAnaymus!= null) {
      Get.offAll(() => const LandingPage());
    }
  }
}
