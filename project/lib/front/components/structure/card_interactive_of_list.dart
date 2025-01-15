import 'package:flutter/material.dart';
import 'package:project/front/style/style.dart';

class CardInteractiveOfList extends StatefulWidget {
  final List<Widget> children;
  final onTap;
  const CardInteractiveOfList({super.key, required this.children, this.onTap});

  @override
  State<CardInteractiveOfList> createState() => _CardInteractiveOfListState();
}

class _CardInteractiveOfListState extends State<CardInteractiveOfList> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(Style.height_8(context)),
        decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal:
                    BorderSide(width: Style.height_1(context), color: Style.disabledColor))),
        child: Container(
          child: Column(children: widget.children),
        ),
      ),
    ));
  }
}
