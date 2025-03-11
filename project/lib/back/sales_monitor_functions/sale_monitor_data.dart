import 'dart:convert';
import 'package:http/http.dart' as http;

class SaleMonitor {
  //Definindo o tipo das variáveis que serão acessadas.
  late String vendedorpessoa_id;
  late double vendabruta;
  late double vendaliquida;
  late double ticketmedio;
  late double mediadiaria;
  late double margem;
  late double valortotaldevolucao;
  late double valortotalcancelamento;
  late double valortotaldesconto;
  late double valortotal;

  SaleMonitor({
    required this.vendedorpessoa_id,
    required this.vendabruta,
    required this.vendaliquida,
    required this.ticketmedio,
    required this.mediadiaria,
    required this.margem,
    required this.valortotaldevolucao,
    required this.valortotalcancelamento,
    required this.valortotaldesconto,
    required this.valortotal,
  });

  factory SaleMonitor.fromJson(Map<String, dynamic> json) {
    return SaleMonitor(
      //Atribuindo os dados do json a essas variáveis.
      vendedorpessoa_id: (json['vendedorpessoa_id'] ?? '').toString(),
      vendabruta: (json['vendabruta'] ?? 0).toDouble(),
      vendaliquida: (json['vendaliquida'] ?? 0).toDouble(),
      ticketmedio: (json['ticketmedio'] ?? 0).toDouble(),
      mediadiaria: (json['mediadiaria'] ?? 0).toDouble(),
      margem: (json['margem'] ?? 0).toDouble(),
      valortotaldevolucao: (json['valortotaldevolucao'] ?? 0).toDouble(),
      valortotalcancelamento: (json['valortotalcancelamento'] ?? 0).toDouble(),
      valortotaldesconto: (json['valortotaldesconto'] ?? 0.0),
      valortotal: (json['valortotal'] ?? 0.0),
    );
  }
}

//Classe responsável por acessar o json e resgatar os campos.
class DataServiceSaleMonitor {
  static Future<Map<String, dynamic>> fetchDataSaleMonitor(
    String pessoa_id,
    String urlBasic,
  ) async {
    //Nesse caso, os dados não serão em lista, pois não haverá mais de um dado para um campo, logo, tive que definir cada campo separadamente.\
    String? vendedorpessoa_id;
    double? vendabruta;
    double? vendaliquida;
    double? ticketmedio;
    double? mediadiaria;
    double? margem;
    double? valortotaldevolucao;
    double? valortotalcancelamento;
    double? valortotaldesconto;
    double? valortotal;

    try {
      //Definindo a url da requisição.
      var urlPost =
          Uri.parse('http://192.168.211.23:8000/api/mock/hoje/$pessoa_id');

      print(urlPost);

      //Variável que irá receber a resposta da requisição.
      var response = await http.get(urlPost);

      if (response.statusCode == 200) {
        //Caso a conexão seja aceita, a variável jsonData acessará o json e resgatará os dados.
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data')) {
          //Caso o campo seja encontrado dentro do json, os dados serão atribuidos a essas variáveis.
          vendedorpessoa_id = jsonData['data'][0]['vendedorpessoa_id'] ?? '';
          vendabruta = (jsonData['data'][0]['vendabruta'] ?? 0).toDouble();
          vendaliquida = (jsonData['data'][0]['vendaliquida'] ?? 0).toDouble();
          ticketmedio = (jsonData['data'][0]['ticketmedio'] ?? 0).toDouble();
          mediadiaria = (jsonData['data'][0]['mediadiaria'] ?? 0).toDouble();
          margem = (jsonData['data'][0]['margem'] ?? 0).toDouble();
          valortotaldevolucao =
              (jsonData['data'][0]['valortotaldevolucao'] ?? 0).toDouble();
          valortotalcancelamento =
              (jsonData['data'][0]['valortotalcancelamento'] ?? 0).toDouble();
          valortotaldesconto =
              (jsonData['data'][0]['valortotaldesconto'] ?? 0).toDouble();
          valortotal = (jsonData['data'][0]['valortotal'] ?? 0).toDouble();
        } else {
          print('Dados do cliente não encontrados');
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }

    // Retorna um mapa contendo os valores
    return {
      'vendedorpessoa_id': vendedorpessoa_id ?? '',
      'vendabruta': vendabruta ?? 0.0,
      'vendaliquida': vendaliquida ?? 0.0,
      'ticketmedio': ticketmedio ?? 0.0,
      'mediadiaria': mediadiaria ?? 0.0,
      'margem': margem ?? 0.0,
      'valortotaldevolucao': valortotaldevolucao ?? 0.0,
      'valortotalcancelamento': valortotalcancelamento ?? 0.0,
      'valortotaldesconto': valortotaldesconto ?? 0.0,
      'valortotal': valortotal ?? 0.0,
    };
  }
}
