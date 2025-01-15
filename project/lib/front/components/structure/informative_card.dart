import 'package:flutter/material.dart';
import 'package:project/front/style/style.dart';

class InformativeCard extends StatefulWidget {
  //Variável para inserir objetos dentro do card
  final List<Widget> children;
  final Color color;

  const InformativeCard({
    Key? key,
    required this.children,
    required this.color,
  }) : super(key: key);

  @override
  State<InformativeCard> createState() => _InformativeCardState();
}

class _InformativeCardState extends State<InformativeCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
        // Código do card
        child: Container(
            padding: EdgeInsets.only(left: Style.height_20(context), right: Style.height_20(context)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: Style.height_350(context),
                  decoration: BoxDecoration(
                      //Estilização do card
                      color: widget.color,
                      borderRadius: BorderRadius.circular(Style.height_10(context)),
                    ),
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
