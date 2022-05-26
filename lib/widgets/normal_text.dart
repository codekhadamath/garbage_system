import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
   const SmallText({Key? key,
     this.size=16,
    required this.text,
     this.color=Colors.grey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
            fontSize: size,
        fontWeight: FontWeight.normal
      )
      );
  }
}