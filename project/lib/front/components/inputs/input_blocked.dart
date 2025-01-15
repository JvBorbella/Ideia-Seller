import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/front/style/style.dart';

class InputBlocked extends StatefulWidget {
  final String value;
  final height;
  final List<TextInputFormatter>? inputFormatters;

  const InputBlocked({
    Key? key,
    required this.value,
    this.height,
    this.inputFormatters,
  });

  @override
  State<InputBlocked> createState() => _InputBlockedState();
}

class _InputBlockedState extends State<InputBlocked> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: widget.height,
        child: TextFormField(
          initialValue: widget.value,
          readOnly: true,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(fontSize: Style.height_10(context)),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black12,
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Style.height_10(context)))),
        ),
      ),
    );
  }
}
