import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spero_app_/Services/getx_controller.dart';

import '../Services/ firestore_operations.dart';

class GetCredentialDataFromDb {
  final User user;
  final Controllers _authController = Get.put(Controllers());
  FireStoreOperations _operations = FireStoreOperations();

  GetCredentialDataFromDb({required this.user});

  void getCollactiondata() {
    _authController.deleteAllItem();
    FirebaseFirestore.instance
        .collection(user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot document) {
        var dataMap = document.data() as Map<String, dynamic>;
        var octoprintIP = dataMap["Octoprint IP"];
        var deviceName = dataMap["Device Name"];
        var octoprintApi = dataMap["Octoprint Api"];



        _authController.addNewItem(deviceName, octoprintIP, octoprintApi);
        _operations.addValue(deviceName, octoprintIP, octoprintApi);
      });
    });
  }
}
