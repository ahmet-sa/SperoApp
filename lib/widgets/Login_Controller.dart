import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;

  void onEmailChanged(String value) => email.value = value;

  void onPasswordChanged(String value) => password.value = value;

  void login() {
    if (email.value.isNotEmpty && password.value.isNotEmpty) {
     
      Get.offAllNamed('/home');
    } else {
      Get.snackbar(
        'Error',
        'Please enter your email and password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
