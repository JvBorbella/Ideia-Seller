import 'package:flutter/material.dart';
import 'package:project/front/style/style.dart';

class TextCard extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight;
  final textAlign;
  final color;

  const TextCard(
      {super.key,
      required this.text,
      required this.fontSize,
      this.FontWeight,
      this.textAlign,
      this.color});

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        color: widget.color != null ? widget.color : Style.primaryColor,
        fontSize: widget.fontSize,
        fontWeight: widget.FontWeight,
      ),
      textAlign: widget.textAlign,
    );
  }
}
