import 'package:flutter/material.dart';

class FloatinButton extends StatelessWidget {
  final String buttonText;
  final Color butonColor;
  final Color textColor;
  final double radius;
  final double height;
  final Widget buttonIcons;
  final VoidCallback onPress;

  const FloatinButton(
      {super.key,
      required this.buttonText,
      required this.butonColor,
      required this.textColor,
      required this.radius,
      required this.height,
      required this.buttonIcons,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPress,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: Row(
        
        children: [
          buttonIcons,
          Text(
            buttonText,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
      backgroundColor: butonColor,
    );
  }
}
