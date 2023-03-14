import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spero_app_/Services/%20firestore_operations.dart';
import 'package:spero_app_/Services/getx_controller.dart';

class OctoprintCredentialShowDialog extends StatelessWidget {
   OctoprintCredentialShowDialog({super.key});

   FireStoreOperations _operations=FireStoreOperations();

   TextEditingController ipContoller = TextEditingController();

  TextEditingController apiControlller = TextEditingController();

  TextEditingController deviceNameController = TextEditingController();

  final Controllers _authController = Get.put(Controllers());

  @override
  Widget build(BuildContext context) {
    return Container();
  }

   Future<List<String>> showDialog() async {
    final result = await Get.dialog(
      SingleChildScrollView(
        child: AlertDialog(
          title: Text('Enter your information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: deviceNameController,
                decoration: InputDecoration(
                  labelText: 'Give device name',
                ),
              ),
              TextFormField(
                controller: ipContoller,
                decoration: InputDecoration(
                  labelText: 'Octoprint IP',
                ),
              ),
              TextFormField(
                controller: apiControlller,
                decoration: InputDecoration(
                  labelText: 'Octoprint Api',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                ipContoller.text = "";
                apiControlller.text = "";
                deviceNameController.text = "";

                Get.back();
              },
            ),
            FloatingActionButton(
              child: Text('Save'),
              onPressed: () {
                String OctoprintIP = ipContoller.text;
                String OctoprintApi = apiControlller.text;
                String DeviceName = deviceNameController.text;
                 _authController.addNewItem(deviceNameController.text, ipContoller.text, apiControlller.text);
                 _operations.addValue(DeviceName, OctoprintIP, OctoprintApi);
                ipContoller.text = "";
                apiControlller.text = "";
                deviceNameController.text = "";
                

       
                

                Get.back(result: [DeviceName, OctoprintIP, OctoprintApi]);
              },
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
    if (result != null) {
      String DeviceName = result[0];
      String OctoprintIP = result[1];
      String OctoprintApi = result[2];



      print(
          'DeviceName $DeviceName ,OctoprintIP: $OctoprintIP, OctoprintApi: $OctoprintApi');
    }

    return [
      ipContoller.text,
      deviceNameController.text,
      deviceNameController.text
    ];
  }
}