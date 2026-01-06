import 'package:flutter/material.dart';
import 'package:project/front/style/style.dart';

class Titles extends StatefulWidget {
  final String text;
  final double fontSize;
  final color;
  final FontWeight;
  final textAlign;

  const Titles(
      {super.key,
      required this.text,
      required this.fontSize,
      this.color,
      this.FontWeight,
      this.textAlign});

  static double h1(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.0384;
  }

  static double h2(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.0288;
  }

  static double h3(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.0224;
  }

  static double h4(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.0192;
  }

  @override
  State<Titles> createState() => _TitlesState();
}

class _TitlesState extends State<Titles> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: widget.color != null ? widget.color : Style.primaryColor,
          fontSize: widget.fontSize,
          fontWeight: widget.FontWeight),
      textAlign: widget.textAlign ?? TextAlign.center,
    );
  }
}
