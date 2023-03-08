import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spero_app_/pages/sign_in_page.dart';

import '../widgets/GetxController.dart';
import 'home.page.dart';

class LandingPage extends StatelessWidget {
  final SignOutConroller _authController = Get.put(SignOutConroller());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return HomePage(user: snapshot.data!);
        } else {
          return SignInPage();
        }
      },
    );
  }
}