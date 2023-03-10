import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FireStoreOperations extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  FireStoreOperations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  addValue(String deviceName, String OctoprintIP, String OctoprintApi) async {
    Map<String, dynamic> _addUser = <String, dynamic>{};

    _addUser["Device Name"] = deviceName;
    _addUser["Octoprint IP"] = OctoprintIP;
    _addUser["Octoprint Api"] = OctoprintApi;
    await _firestore.collection(_auth.currentUser!.uid).doc(OctoprintApi).set(_addUser);
}
}