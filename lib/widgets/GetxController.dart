import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spero_app_/pages/log_in_page.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../model/octoprint_credential.dart';
import '../pages/home.page.dart';

class Controllers extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 
   var items = <OctoprintCrendentialModel>[].obs;
  final isButtonEnabled = false.obs;



  void addNewItem(String name, String Ip,String Api) {
    OctoprintCrendentialModel newItem = OctoprintCrendentialModel(
      deviceName: name,
      OctoprintIP:Ip ,
      OctoprintApi: Api,
    );
    
    items.add(newItem);
  }


 void deleteItem(OctoprintCrendentialModel item) {
  items.remove(item);
}




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
   Get.to(() => SignInPage());
  }

  
}
