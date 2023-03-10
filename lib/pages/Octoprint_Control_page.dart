import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spero_app_/widgets/buttons.dart';
import 'dart:io';

class OctoprinControlPage extends StatefulWidget {
  final String Ip;
  final String Api;
  const OctoprinControlPage({super.key, required this.Ip, required this.Api});


  @override
  State<OctoprinControlPage> createState() => _OctoprinControlPageState();
}

class _OctoprinControlPageState extends State<OctoprinControlPage> {

  String printerStatus = '';
  double _tablePosition = 0.0;

  final String portName = '/dev/ttyACM0'; // Replace with your serial port name
  final int baudRate = 9600; // Replace with your ESP32's baud rate

  // Define the message to send to the ESP32
  final String messageToSend = '[CMD] MotorForward|123\n';

  final octoPrintUrl = 'http://192.168.1.102/api';
  int extruderTemp = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(color: Colors.red),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Spero App"),
      ),
      body: Column(
        children: [
          Button(
              onPress: () {
                setExtruderTemp(60);
                debugPrint(widget.Api+widget.Ip);
              },
              butonColor: Colors.red,
              radius: 10,
              buttonText: "Set Temp to 60",
              buttonIcon: Icon(Icons.arrow_back),
              height: 80,
              textColor: Colors.white),
          Button(
              onPress: () {
                setMove(10);
              },
              butonColor: Colors.red,
              radius: 10,
              buttonText: "table move 10 forward",
              buttonIcon: Icon(Icons.arrow_back),
              height: 80,
              textColor: Colors.white),
          Button(
              onPress: () {
                setMove(-10);
              },
              butonColor: Colors.red,
              radius: 10,
              buttonText: "table move 10 backward",
              buttonIcon: Icon(Icons.arrow_back),
              height: 80,
              textColor: Colors.white),
          Button(
              onPress: () {
                createQueue();
              },
              butonColor: Colors.red,
              radius: 10,
              buttonText: "Create Qeueue",
              buttonIcon: Icon(Icons.arrow_back),
              height: 80,
              textColor: Colors.white),
          Button(
              onPress: () {
                sendDeviceControl('eject');
              },
              butonColor: Colors.red,
              radius: 10,
              buttonText: "eject",
              buttonIcon: Icon(Icons.arrow_back),
              height: 80,
              textColor: Colors.white),
          Button(
              onPress: () {
                sendDeviceControl('forward');
              },
              butonColor: Colors.red,
              radius: 10,
              buttonText: "forward",
              buttonIcon: Icon(Icons.arrow_back),
              height: 80,
              textColor: Colors.white),
          Button(
              onPress: () {
                sendDeviceControl('backward');
              },
              butonColor: Colors.red,
              radius: 10,
              buttonText: "backward",
              buttonIcon: Icon(Icons.arrow_back),
              height: 80,
              textColor: Colors.white),
          Button(
              onPress: () {
                sendDeviceControl('stop');
              },
              butonColor: Colors.red,
              radius: 10,
              buttonText: "stop",
              buttonIcon: Icon(Icons.arrow_back),
              height: 10,
              textColor: Colors.white),
        ],
      ),
    );
  }

  void sendDeviceControl(String data) async {
    try {
      final json = {'request': data};
      final response = await Dio().post(
        '${widget.Ip}/plugin/speroplugin/device-control',
        options: Options(
          headers: {
            'X-Api-Key': widget.Api,
          },
          contentType: Headers.jsonContentType,
        ),
        data: json,
      );

      if (response.statusCode == 200) {
        debugPrint("yes");
      } else {
        debugPrint("no");
      }
    } catch (error) {
      print('sendDeviceControl => $error');
    }
  }

  void createQueue() async {
    final response = await http.get(
      Uri.parse('${widget.Ip}/api/plugin/speroplugin/create-queue'),
      headers: {
        'X-Api-Key': widget.Api,
      },
    );

    if (response.statusCode == 200) {
      debugPrint("yes");
    } else {
      debugPrint("no");
    }
  }

  void setMove(int distance) async {
    try {
      await Dio().post('${widget.Ip}/api/printer/printhead',
          data: {
            'command': 'jog',
            'y': distance,
          },
          options: Options(headers: {'X-Api-Key': widget.Api}));
      setState(() {
        _tablePosition += distance;
      });
    } catch (e) {
      print('Error setting extruder temperature: $e');
    }
  }

  void setExtruderTemp(int temp) async {
    try {
      await Dio().post('${widget.Ip}/api/printer/tool',
          data: {
            'command': 'target',
            'targets': {'tool0': temp}
          },
          options: Options(headers: {'X-Api-Key': widget.Api}));
      setState(() {
        extruderTemp = temp;
      });
    } catch (e) {
      print('Error setting extruder temperature: $e');
    }
  }
}
