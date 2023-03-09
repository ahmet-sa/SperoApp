import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/GetxController.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.user});
  final Controllers _authController = Get.put(Controllers());
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ana sayfa"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Get.find<Controllers>().signOut(),
          ),
        ],
      ),
      body: Stack(
        children: [
         Center(child: Text("hosgeldiniz ${user.uid}")),
          Container(
            color: Colors.white,
            child: Center(
              child: Text('Hello, World! ${user.email}'),
            ),
          ),
          // Round button in the bottom right corner
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                _authController.showDialog();
                
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}





 

