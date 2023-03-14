import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spero_app_/pages/log_in_page.dart';

import '../widgets/get_credential_data_from_db.dart';
import 'device_select_page.dart';

class LandingPage extends StatelessWidget {
  late GetCredentialDataFromDb dialog ;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {

          debugPrint("log in");
            dialog =GetCredentialDataFromDb(user: snapshot.data!,);
            dialog.getCollactiondata();
          return DeviceSelectPage(user: snapshot.data!);
        } else {
          return const SignInPage();
        }
      },
    );
  }
}