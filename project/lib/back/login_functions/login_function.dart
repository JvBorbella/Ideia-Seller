import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:project/Front/style/style.dart';
import 'package:project/back/company/company_infos.dart';
import 'package:project/front/pages/seller_monitor_page.dart';
import 'package:project/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Código da função de login

class LoginFunction {
  static Future<void> login(
    //BuildContext para permitir que sejam criadas mensagens de alerta conforme as tentativas e erros nesta classe.
    BuildContext context,
    //Recebendo os dados armazenados que serão necessário para efetuar a função.
    String url,
    TextEditingController userController,
    TextEditingController passwordController,
  ) async {
    //Tentando fazer a requisição ao servidor.
    try {
      //Definindo variáveis que serão utilizadas na requisição

      var username = userController.text;
      //username: recebe o valor digitado no input de usuário na tela de login.
      var password = passwordController.text;
      //password: recebe o valor digitado no input de senha na tela de login.
      var md5Password = md5.convert(utf8.encode(password)).toString();
      //md5Password: criptografa a senha digitada em md5 Hash pois o servidor só aceita requisição com a senha já criptografada.
      var authorization = Uri.parse('$url/ideia/secure/login');
      //authorization: define a url que fará a requisição post ao servidor.

      var pessoaId = '';
      var codigo = '';
      var nome = '';
      var imagem = '';

      print(authorization);

      //response: variável definida para receber a resposta da requisição post do servidor.
      var response = await http.post(
        authorization, //passando a url da requisição
        headers: {
          //passando os parâmetros na header da requisição.
          'auth-user': username,
          'auth-pass': md5Password,
        },
      );
      print(response.statusCode);

      //Caso o servidor aceite a conexão, o token será resgatado no json e armazenado no sharedpreferences.
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          var token = responseBody['data']['token'];
          var login = responseBody['data']['login'];
          var usuarioId = responseBody['data']['id'];
          var image = responseBody['data']['image'];
          var email = responseBody['data']['email'];
          var empresaid = responseBody['data']['empresa_id'] ?? '';
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString('token', token);
          await sharedPreferences.setString('login', login);
          await sharedPreferences.setString('image', image);
          await sharedPreferences.setString('url', '$url/ideia/secure');
          await sharedPreferences.setString('urlBasic', url);
          await sharedPreferences.setString('email', email);
          await sharedPreferences.setString('empresa_id', empresaid);
          print(token);

          try {
            var urlSeller = Uri.parse(
                '''$url/ideia/core/getdata/pessoa%20p%20LEFT%20JOIN%20usuario%20u%20ON%20u.pessoa_id%20=%20p.pessoa_id%20WHERE%20u.usuario_id%20=%20'$usuarioId'/''');
            var headers = ({"Accept": "text/html"});
            var response = await http.get(urlSeller, headers: headers);
            if (response.statusCode == 200) {
              var data = jsonDecode(response.body);
              var dynamicKey = data['data'].keys.first;
              // pega a lista de registros
              List<dynamic> list = data['data'][dynamicKey];
              Map<String, dynamic> vendedor = list.first;
              print(data['data'][dynamicKey][0]['codigo']?.toString() ?? '');
              var vendedorId = vendedor['pessoa_id']?.toString() ?? '';
              var codigoVendedor = vendedor['codigo']?.toString() ?? '';
              var nomeVendedor = vendedor['nome']?.toString() ?? '';
              var imagemVendedor = vendedor['imagem_url']?.toString() ?? '';
              var email = vendedor['email'];
              var empresaid = vendedor['empresa_id'] ?? '';

              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              await sharedPreferences.setString('vendedor_id', vendedorId);
              await sharedPreferences.setString('codigo', codigoVendedor);
              await sharedPreferences.setString('nome', nomeVendedor);
              await sharedPreferences.setString('email', email);
              await sharedPreferences.setString('empresa_id', empresaid);

              pessoaId = vendedorId ?? '';
              codigo = codigoVendedor ?? '';
              nome = nomeVendedor ?? '';
              imagem = imagemVendedor ?? '';

            } else {
              print('Problema na requisição: ${response.body}');
            }
          } catch (e) {
            print(
                'Erro durante a requisição do vendedor a partir do login: $e');
          }

          final fetchdata = await DataServiceCompany.fetchDataCompany(
                  context, url, empresaid);
              print(fetchdata!.first.empresa_codigo);
              await sharedPreferences.setString(
                  'empresa_codigo', fetchdata!.first.empresa_codigo ?? '');
              await sharedPreferences.setString(
                  'empresa_nome', fetchdata.first.empresa_nome ?? '');

// Navegue para a HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SellerMonitorPage(
                    userController: userController.text,
                    vendedorId: pessoaId,
                    codigo: codigo,
                    nome: nome,
                    imagemUrl: imagem)),
          );
        } else {
          ErrorHandler.showSnackBar(context, responseBody['message']);
        }
      } else {
        final msg = ErrorHandler.getMessage(null, response.statusCode);
        ErrorHandler.showSnackBar(context, msg);
      }
      //Caso a tentativa de requisição não retorne o status 200, será exibida essa mensagem
    } catch (e) {
      final msg = ErrorHandler.getMessage(e);
      ErrorHandler.showSnackBar(context, msg);
      print("Erro: $e");
    }
  }
}

class ErrorHandler {
  static String getMessage(dynamic error, [int? statusCode]) {
    if (error is Exception) {
      // Aqui você pode tratar exceções de rede
      if (error.toString().contains("SocketException")) {
        return "Sem conexão com o servidor.";
      }
      if (error.toString().contains("TimeoutException")) {
        return "Tempo de conexão excedido.";
      }
      return "Erro inesperado. Tente novamente.";
    }

    // Tratamento por código HTTP
    switch (statusCode) {
      case 400:
        return "Requisição inválida.";
      case 401:
        return "Usuário ou senha incorretos.";
      case 403:
        return "Você não tem permissão para acessar.";
      case 404:
        return "Servidor não encontrado.";
      case 408:
        return "Tempo de conexão excedido.";
      case 419:
        return "Sessão expirada. Faça login novamente.";
      case 500:
        return "Erro interno no servidor.";
      default:
        return "Não foi possível processar sua solicitação.";
    }
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
