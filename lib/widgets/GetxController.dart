import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spero_app_/pages/sign_in_page.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../pages/home.page.dart';

class Controllers extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  TextEditingController ipContoller = TextEditingController();
  TextEditingController apiControlller = TextEditingController();

  final isButtonEnabled = false.obs;

  bool validateFields() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  updateButtonEnabled() {
    isButtonEnabled.value = validateFields();
  }

  onInit() {
    super.onInit();
    emailController.addListener(updateButtonEnabled);
    passwordController.addListener(updateButtonEnabled);
  }

  void login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.offAll(() => HomePage(
            user: _auth.currentUser!,
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "User not found");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Wrong password");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.to(SignInPage());
  }

  void showDialog() async {
    final result = await Get.dialog(
      AlertDialog(
        title: Text('Enter your information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: ipContoller,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: apiControlller,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Get.back();
            },
          ),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () {
              String name = ipContoller.text;
              String email = apiControlller.text;
              Get.back(result: [name, email]);
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
    if (result != null) {
      String name = result[0];
      String email = result[1];
      print('Name: $name, Email: $email');
    }
  }
}
