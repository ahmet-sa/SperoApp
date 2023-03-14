import 'package:flutter/material.dart';

class IconButtons extends StatelessWidget {
    final Widget buttonIcon;
    final VoidCallback onPress;

  const IconButtons({super.key, required this.buttonIcon, required this.onPress});



  @override
  Widget build(BuildContext context) {
    return Container(
            height: 50,
            width: 50,
            color: Colors.grey.shade300,
            
            child: IconButton(icon: buttonIcon, onPressed: onPress,)
            
            );

  }
}