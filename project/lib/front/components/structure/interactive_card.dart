import 'package:flutter/material.dart';
import 'package:project/front/style/style.dart';

class InteractiveCard extends StatefulWidget {
  //Variável para inserir objetos dentro do card
  final List<Widget> children;
  final String Text;
  final icon;
  final onPressed;

  const InteractiveCard(
      {Key? key,
      required this.children,
      required this.Text,
      this.icon,
      this.onPressed})
      : super(key: key);

  @override
  State<InteractiveCard> createState() => _InteractiveCardState();
}

class _InteractiveCardState extends State<InteractiveCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
        // Código do card
        child: Container(
            padding: EdgeInsets.only(
                left: Style.height_20(context),
                right: Style.height_20(context)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () {
                          if (widget.onPressed != null) {
                            widget.onPressed();
                          }
                        },
                  child: Container(
                    height: Style.height_30(context),
                  width: Style.height_350(context),
                  decoration: BoxDecoration(
                      color: Style.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Style.height_10(context)),
                        topRight: Radius.circular(Style.height_10(context)),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                            //Texto do button está sendo definido na página home.Dart
                            widget.Text,
                            style: TextStyle(
                                fontSize: Style.height_12(context),
                                fontWeight: FontWeight.bold,
                                color: Style.tertiaryColor),
                            textAlign: TextAlign.center,
                          ),
                      Icon(
                        widget.icon,
                        color: Style.tertiaryColor,
                        size: Style.height_12(context),
                      )
                    ],
                  ),
                ),
                ),
                Container(
                  width: Style.height_350(context),
                  decoration: BoxDecoration(
                      //Estilização do card
                      border: Border.all(
                          width: Style.height_2(context),
                          color: Style.primaryColor),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(Style.height_10(context)),
                        bottomRight: Radius.circular(Style.height_10(context)),
                      )),
                  //Parte do código para que sejam atribuidos os widgets definidos no código da tela que ficarão dentro do card
                  child: Column(
                    children: widget.children,
                  ),
                  padding: EdgeInsets.all(Style.height_10(context)),
                ),
              ],
            )));
  }
}
