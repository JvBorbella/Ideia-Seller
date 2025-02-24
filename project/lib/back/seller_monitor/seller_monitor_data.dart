import 'dart:convert';
import 'package:http/http.dart' as http;

class SellerMonitor {
  //Definindo o tipo das variáveis que serão acessadas.
  late String pessoa_id;
  late String codigo;
  late String nome;
  late String email;
  late String empresa_id;
  late String empresa_codigo;
  late String empresa_nome;
  late String imagem;
  late double vendashoje;
  late double vendasontem;
  late double vendassemana;
  late double vendasmes;
  late double vendasmesanterior;
  late int clientes_inadimplentes;
  late int clientes_adimplentes;
  late int clientes_restantes;

  SellerMonitor({
    required this.pessoa_id,
    required this.codigo,
    required this.nome,
    required this.email,
    required this.empresa_id,
    required this.empresa_codigo,
    required this.empresa_nome,
    required this.imagem,
    required this.vendashoje,
    required this.vendasontem,
    required this.vendassemana,
    required this.vendasmes,
    required this.vendasmesanterior,
    required this.clientes_inadimplentes,
    required this.clientes_adimplentes,
    required this.clientes_restantes,
  });

  factory SellerMonitor.fromJson(Map<String, dynamic> json) {
    return SellerMonitor(
      //Atribuindo os dados do json a essas variáveis.
      pessoa_id: (json['pessoa_id'] ?? '').toString(),
      codigo: (json['codigo'] ?? '').toString(),
      nome: (json['nome'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      empresa_id: (json['empresa_id'] ?? '').toString(),
      empresa_codigo: (json['empresa_codigo'] ?? '').toString(),
      empresa_nome: (json['empresa_nome'] ?? '').toString(),
      imagem: (json['imagem'] ?? '').toString(),
      vendashoje: (json['vendashoje'] ?? 0.0),
      vendasontem: (json['vendasontem'] ?? 0.0),
      vendassemana: (json['vendassemana'] ?? 0.0),
      vendasmes: (json['vendasmes'] ?? 0.0),
      vendasmesanterior: (json['vendasmesanterior'] ?? 0.0),
      clientes_inadimplentes: (json['clientes_inadimplentes'] ?? 0),
      clientes_adimplentes: (json['clientes_adimplentes'] ?? 0),
      clientes_restantes: (json['clientes_restantes'] ?? 0),
    );
  }
}

//Classe responsável por acessar o json e resgatar os campos.
class DataServiceSellerMonitor {
  static Future<Map<String, dynamic>> fetchDataSellerMonitor(
    String usuario,
    String urlBasic,
  ) async {
    //Nesse caso, os dados não serão em lista, pois não haverá mais de um dado para um campo, logo, tive que definir cada campo separadamente.\
    String? pessoa_id;
    String? codigo;
    String? nome;
    String? email;
    String? empresa_id;
    String? empresa_codigo;
    String? empresa_nome;
    String? imagem;
    double? vendashoje;
    double? vendasontem;
    double? vendassemana;
    double? vendasmes;
    double? vendasmesanterior;
    int? clientes_inadimplentes;
    int? clientes_adimplentes;
    int? clientes_restantes;

    try {
      //Definindo a url da requisição.
      var urlPost =
          Uri.parse('http://192.168.134.194:8000/api/mock/vendedor/$usuario');

      //Variável que irá receber a resposta da requisição.
      var response = await http.get(urlPost);

      if (response.statusCode == 200) {
        //Caso a conexão seja aceita, a variável jsonData acessará o json e resgatará os dados.
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data')) {
          //Caso o campo seja encontrado dentro do json, os dados serão atribuidos a essas variáveis.
          pessoa_id = jsonData['data'][0]['pessoa_id'] ?? '';
          codigo = jsonData['data'][0]['codigo'] ?? '';
          nome = jsonData['data'][0]['nome'] ?? '';
          email = jsonData['data'][0]['email'] ?? '';
          empresa_id = jsonData['data'][0]['empresa_id'] ?? '';
          empresa_codigo = jsonData['data'][0]['empresa_codigo'] ?? '';
          empresa_nome = jsonData['data'][0]['empresa_nome'] ?? '';
          imagem = jsonData['data'][0]['imagem'] ?? '';
          vendashoje = (jsonData['data'][0]['vendashoje'] ?? 0).toDouble();
          vendasontem = (jsonData['data'][0]['vendasontem'] ?? 0).toDouble();
          vendassemana = (jsonData['data'][0]['vendassemana'] ?? 0).toDouble();
          vendasmes = (jsonData['data'][0]['vendasmes'] ?? 0).toDouble();
          vendasmesanterior = (jsonData['data'][0]['vendasmesanterior'] ?? 0).toDouble();
          clientes_inadimplentes =
              jsonData['data'][0]['clientes_inadimplentes'] ?? 0;
          clientes_adimplentes =
              jsonData['data'][0]['clientes_adimplentes'] ?? 0;
          clientes_restantes = jsonData['data'][0]['clientes_restantes'] ?? 0;
        } else {
          print('Dados do cliente não encontrados');
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }

    // Retorna um mapa contendo os valores
    return {
      'pessoa_id': pessoa_id ?? '',
      'codigo': codigo ?? '',
      'nome': nome ?? '',
      'email': email ?? '',
      'empresa_id': empresa_id ?? '',
      'empresa_codigo': empresa_codigo ?? '',
      'empresa_nome': empresa_nome ?? '',
      'imagem': imagem ?? '',
      'vendashoje': vendashoje ?? 0.0,
      'vendasontem': vendasontem ?? 0.0,
      'vendassemana': vendassemana ?? 0.0,
      'vendasmes': vendasmes ?? 0.0,
      'vendasmesanterior': vendasmesanterior ?? 0.0,
      'clientes_inadimplentes': clientes_inadimplentes ?? 0,
      'clientes_adimplentes': clientes_adimplentes ?? 0,
      'clientes_restantes': clientes_restantes ?? 0,
    };
  }
}
