import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const TitleText({super.key, required this.text, this.color = Colors.deepPurple, this.fontSize = 28});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: color), textAlign: TextAlign.center);
  }
}
