import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final color;
  final textColor;
  final String textButton;
  final buttonTap;

  MyButtons({this.color, this.textButton, this.textColor, this.buttonTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                textButton,
                style: TextStyle(color: textColor, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
