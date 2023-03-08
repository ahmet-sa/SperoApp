import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home.page.dart';

class SignOutConroller extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
    Get.offAll(() => HomePage(user: _auth.currentUser!,));
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
  }




  
}