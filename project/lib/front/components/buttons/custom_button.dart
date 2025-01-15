import 'package:flutter/material.dart';
import 'package:project/front/style/style.dart';

class CustomButton extends StatefulWidget {
  //Variável para definir o texto do button na página em que é chamado
  final String text;
  final double fontSize;
  final FontWeight;
  //Variável para definir o destino ao clicar no button na página em que é chamado
  final onPressed;
  //Variável para definir o tamanho do button na página em que é chamado
  final color;
  final backgroundColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.fontSize,
    this.FontWeight,
    this.onPressed,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButton();
}

class _CustomButton extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        //Alinhamento do button
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(Style.height_5(context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Style.height_15(context)),
              color: widget.backgroundColor
            ),
            child: TextButton(
            //Redirecionamento executado ao clicar no button. Definido na página em que o button está sendo chamado.
            onPressed: () {
              if (widget.onPressed != null) {
                widget.onPressed();
              }
            },
            child: Text(
              //Texto do button está sendo definido na página em que está sendo chamado.
              widget.text,
              //Estilização do button
              style: TextStyle(
                color: widget.color,
                fontWeight: widget.FontWeight,
                fontSize: widget.fontSize,
              ),
            ),
          ),
          )
        ],
      ),
    );
  }
}
