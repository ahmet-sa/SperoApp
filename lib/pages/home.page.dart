import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spero_app_/widgets/buttons.dart';

import '../widgets/GetxController.dart';
import '../widgets/Octoprint_Credential_Showdialog.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.user});
  final Controllers _authController = Get.put(Controllers());
  final User user;
  OctoprintCredentialShowDialog dialog = OctoprintCredentialShowDialog();

  @override
  Widget build(BuildContext context) {
    Future<List<String>> buttonDetail;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              child: Obx(() {
                return ListView.builder(
                  itemCount: _authController.items.length +
                      1, // add one for the add button
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _authController.items.length) {
                      return Center();
                    } else {
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 400,
                              child: FloatingActionButton.extended(
                                onPressed: () {},
                                label: Column(
                                  children: [
                                    Text(_authController
                                        .items[index].deviceName),
                                    Text(_authController
                                        .items[index].OctoprintIP),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              }),
            ),
            Center(child: Text("hosgeldiniz ${user.email}")),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () async {
                  await dialog.showDialog();
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
