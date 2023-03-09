import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spero_app_/pages/sign_in_email_and_password_credential_page.dart';
import '../Services/AuthService.dart';
import '../widgets/GetxController.dart';

import '../widgets/buttons.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
   final String _email = "emrealtunbilek@gmail.com";
   final String _password = "password123";
  final SignOutConroller _authController = Get.put(SignOutConroller());
  late FirebaseAuth auth;
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
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
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _authController.emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _authController.passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Obx(() => ElevatedButton(
                        onPressed: _authController.isButtonEnabled.value
                            ? _authController.login
                            : null,
                        child: Text('Login'),
                      )),
                ],
              ),
            ),
            SizedBox(height: 8),
            Button(
              buttonText: "Sign in With Google",
              butonColor: Colors.white,
              textColor: Colors.black87,
              radius: 16,
              height: 80,
              buttonIcon: Image.asset("images/google-logo.png"),
              onPress: () {
                _authService.signInWithGoogle();
              },
            ),
            Button(
              buttonText: "Sign in With Facebook",
              butonColor: Color(0xFF334D92),
              textColor: Colors.white,
              radius: 16,
              height: 80,
              buttonIcon: Image.asset("images/facebook-logo.png"),
              onPress: () {_authService.loginWithFacebook();},
            ),
            Button(
              buttonText: "Sign in Email and Passward",
              butonColor: Colors.purple,
              textColor: Colors.white,
              radius: 16,
              height: 80,
              buttonIcon: Icon(
                Icons.email,
                size: 28,
              ),
              onPress: () {  Get.to(SignInEmailAndPassward());;},
            ),
            Button(
              buttonText: "guest entry",
              butonColor: Colors.orange,
              textColor: Colors.white,
              radius: 16,
              height: 80,
              buttonIcon: Icon(
                Icons.supervised_user_circle,
                size: 28,
              ),
              onPress: () {
                _authService.signInAnaymus();
              },
            ),
          ],
        ),
      ),
    );
  }





}
