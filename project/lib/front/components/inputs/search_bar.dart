import 'package:flutter/material.dart';
import 'package:project/Front/style/style.dart';

class SearchBarDefault extends StatefulWidget {
  final controller;
  final hintText;
  final onPressedClear;
  final onPressedPrefix;
  final suffixIcon;
  final onPressedSuffix;
  final onSubmited;
  final onChanged;
  final flagClear;
  final inputFormatters;
  final keyboardType;

  const SearchBarDefault(
      {Key? key,
      this.controller,
      this.hintText,
      this.onPressedClear,
      this.onPressedPrefix,
      this.suffixIcon,
      this.onPressedSuffix,
      this.onSubmited,
      this.onChanged,
      this.flagClear,
      this.inputFormatters,
      this.keyboardType})
      : super(key: key);

  @override
  State<SearchBarDefault> createState() => _SearchBarDefaultState();
}

class _SearchBarDefaultState extends State<SearchBarDefault> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        onSubmitted: widget.onSubmited,
        controller: widget.controller,
        style: TextStyle(fontSize: Style.height_15(context)),
        enabled: true,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(Style.height_8(context)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: Style.height_1(context)),
            borderRadius: BorderRadius.all(
              Radius.circular(Style.height_30(context)),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Style.height_30(context)),
            ),
          ),
          prefixIcon: IconButton(
            padding: EdgeInsets.only(left: Style.height_12(context)),
            onPressed: widget.onPressedPrefix,
            icon: Icon(Icons.search),
            color: Style.secondaryColor,
            iconSize: Style.height_30(context),
          ),
          suffixIcon: widget.suffixIcon,
          // Container(
          //   width: 100,
          //   child: Row(
          //     children: [
          //       IconButton(
          //         onPressed: () {},
          //         icon: Icon(Icons.backspace_rounded),
          //         color: Style.errorColor,
          //         iconSize: Style.height_15(context),
          //       ),
          //       IconButton(
          //         onPressed: widget.onPressedSuffix,
          //         icon: Icon(Icons.filter_alt_rounded),
          //         color: Style.secondaryColor,
          //         iconSize: Style.height_15(context),
          //       ),
          //     ],
          //   ),
          // ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: Style.height_10(context), color: Style.quarantineColor),
        ),
      ),
    );
  }
}
