import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignOutConroller extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut();
  }
}