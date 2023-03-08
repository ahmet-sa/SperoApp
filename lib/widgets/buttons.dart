import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final Color butonColor;
  final Color textColor;
  final double radius;
  final double height;
  final Widget buttonIcon;
  final VoidCallback onPress;

  const Button(
      {super.key,
      required this.buttonText,
      required this.butonColor,
      required this.textColor,
      required this.radius,
      required this.height,
      required this.buttonIcon,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      child: SizedBox(
        height: height,
        child: Container(
          height: 70,
          width: 500,
          padding: const EdgeInsets.all(10),
          child: FloatingActionButton(
            heroTag: buttonText,
            onPressed: onPress,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius))),
            backgroundColor: butonColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttonIcon!=null ? buttonIcon:Container(),
                  Text(
                    buttonText,
                    style: TextStyle(color: textColor),
                  ),
                  Opacity(opacity: 0,child:  buttonIcon!=null ? buttonIcon:Container()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}