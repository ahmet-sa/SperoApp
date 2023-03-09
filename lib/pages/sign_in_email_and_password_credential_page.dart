import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spero_app_/widgets/buttons.dart';

import '../Services/AuthService.dart';

class SignInEmailAndPassward extends StatefulWidget {
  const SignInEmailAndPassward({super.key});

  @override
  State<SignInEmailAndPassward> createState() => _SignInEmailAndPasswardState();
}

class _SignInEmailAndPasswardState extends State<SignInEmailAndPassward> {
  late final AuthService _authService;
  RxString _Email = ''.obs;
  RxString _password = ''.obs;

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spero APP"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: textController1,
              decoration: InputDecoration(
                labelText: 'Enter your mail',
              ),
              onChanged: (value) {
                _Email.value = value;
              },
            ),
            TextFormField(
              controller: textController2,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter your Password',
              ),
              
              onChanged: (value) {
                _password.value = value;
              },
            ),
            SizedBox(height: 20),
            Button(
              buttonText: "Sign in",
              butonColor: Colors.orange,
              textColor: Colors.white,
              radius: 10,
              height: 60,
              buttonIcon: Icon(Icons.access_alarm_outlined),
              onPress: () {
                _authService.SignInWithEmailAndPassword(
                    _Email.value, _password.value);
              },
            )
          ],
        ),
      ),
    );
  }
}
