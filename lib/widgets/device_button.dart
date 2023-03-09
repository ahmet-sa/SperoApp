import 'package:flutter/material.dart';

class DeviceButton extends StatelessWidget {
  final String deviceName;
  final String OctoprintIp;
  final String OctoprintApi;


  const DeviceButton({required this.deviceName, required this.OctoprintIp, required this.OctoprintApi});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
      ),
      
      
      child: Column(
        children: [
          Text(deviceName),
          Text(OctoprintIp),
          Text(OctoprintApi),
          
        ],
        
        
      )
    );
  }
}