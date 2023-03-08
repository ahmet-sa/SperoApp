import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/landing_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  



  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
      return null;
    }
  }

   Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
          Get.offAll(() => LandingPage());
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    }
  }


  


  Future<void> signInAnaymus() async {
    var _userAnaymus = await _auth.signInAnonymously();

    if (_userAnaymus != null) {
      Get.offAll(() => LandingPage());
    }
  }





}