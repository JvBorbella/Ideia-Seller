import 'dart:convert';
import 'package:http/http.dart' as http;

class SaleList {
  //Definindo o tipo das variáveis que serão acessadas.
  late String vendedorpessoa_id;
  late String movimentosaida_id;
  late DateTime? datahora;
  late String nomecondicaopagamento;
  late String numeromovimento;
  late int flagvendaservico;
  late double margem;
  late double valortotal;
  late String pessoa_nome;

  SaleList(
      {required this.vendedorpessoa_id,
      required this.movimentosaida_id,
      required this.datahora,
      required this.nomecondicaopagamento,
      required this.numeromovimento,
      required this.flagvendaservico,
      required this.margem,
      required this.valortotal,
      required this.pessoa_nome});

  factory SaleList.fromJson(Map<String, dynamic> json) {
    return SaleList(
      //Atribuindo os dados do json a essas variáveis.
      vendedorpessoa_id: (json['vendedorpessoa_id'] ?? '').toString(),
      movimentosaida_id: (json['movimentosaida_id'] ?? ''),
      datahora:
          json['datahora'] != null ? DateTime.parse(json['datahora']) : null,
      nomecondicaopagamento: (json['nomecondicaopagamento'] ?? ''),
      numeromovimento: (json['numeromovimento'] ?? ''),
      flagvendaservico: (json['flagvendaservico'] ?? 0).toInt(),
      margem: (json['margem'] ?? 0).toDouble(),
      valortotal: (json['valortotal'] ?? 0).toDouble(),
      pessoa_nome: json['pessoa_nome'] ?? '',
    );
  }
}

//Classe responsável por acessar o json e resgatar os campos.
class DataServiceSaleList {
  static Future<List<SaleList>?> fetchDataSaleList(
    String pessoa_id,
    String urlBasic,
  ) async {
    //Nesse caso, os dados não serão em lista, pois não haverá mais de um dado para um campo, logo, tive que definir cada campo separadamente.\
    List<SaleList>? saleList;

    try {
      //Definindo a url da requisição.
      var urlPost =
          Uri.parse('http://192.168.211.23:8000/api/mock/vendas/$pessoa_id');

      print(urlPost);

      //Variável que irá receber a resposta da requisição.
      var response = await http.get(urlPost);

      if (response.statusCode == 200) {
        //Caso a conexão seja aceita, a variável jsonData acessará o json e resgatará os dados.
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data')) {
          //Caso o campo seja encontrado dentro do json, os dados serão atribuidos a essas variáveis.
          saleList = (jsonData['data'] as List)
              .map((e) => SaleList.fromJson(e))
              .toList();
        } else {
          print('Dados do cliente não encontrados');
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }

    // Retorna um mapa contendo os valores
    return saleList;
  }
}
