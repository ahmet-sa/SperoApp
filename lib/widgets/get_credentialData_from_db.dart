import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetCredentialDataFromDb {
  final User user;

  const GetCredentialDataFromDb({required this.user});

  void getCollactiondata() {
    FirebaseFirestore.instance
        .collection(user.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot document) {
        debugPrint("asd");
        debugPrint(document.data().toString());
      });
    });
  }
}
