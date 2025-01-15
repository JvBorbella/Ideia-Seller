import 'package:flutter/material.dart';
import 'package:project/front/style/style.dart';
import 'package:project/Front/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Código da função para salvar a URL digitada na tela Config().

class SaveUrlFunction {
  Future<void> saveUrlFunction(BuildContext context, String url) async {
    //Salvando o texto digitado no input por meio da biblioteca SharedPreferences.
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('saveUrl',
        url); //Referenciando o texto armazenado através de 'saveUrl'.
    //Ao efetuar o processo acima, será exibida a mensagem:
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
        content: Text(
          'IP salvo com sucesso!',
          style: TextStyle(
            fontSize: Style.SaveUrlMessageSize(context),
          ),
        ),
        backgroundColor: Style.sucefullColor,
      ),
    );
    //E o usuário será redirecionado para a tela de Login().
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            LoginPage(), //No redirecionamento será passada a url armazenada.
      ),
    );
  }
}
