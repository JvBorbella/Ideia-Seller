import 'dart:convert';

import 'package:http/http.dart' as http;

class CustomerDetail {
  final codigo;
  final nome;
  final data_ultima_venda;
  final data_ultimo_pagamento;
  final valor_total_vendas;
  final valor_total_devolucoes;
  final valor_total_credito;
  final qtde_vencido;
  final valor_vencido;
  final valor_a_vencer;
  final valor_devedor;
  final limitecredito;
  
  CustomerDetail({
    this.codigo, 
    this.nome,
    this.data_ultima_venda,
    this.data_ultimo_pagamento,
    this.valor_total_vendas,
    this.valor_total_devolucoes,
    this.valor_total_credito,
    this.qtde_vencido,
    this.valor_vencido,
    this.valor_a_vencer,
    this.valor_devedor,
    this.limitecredito
  });

  factory CustomerDetail.fromJson(Map<String, dynamic> json) {
    return CustomerDetail(
      codigo: json['codigo'],
      nome: json['nome'],
      data_ultima_venda: json['data_ultima_venda'] != null &&
                   json['data_ultima_venda'].toString().isNotEmpty
    ? DateTime.parse(json['data_ultima_venda'])
    : null,
      data_ultimo_pagamento: json['data_ultimo_pagamento'] != null &&
                   json['data_ultimo_pagamento'].toString().isNotEmpty
    ? DateTime.parse(json['data_ultimo_pagamento'])
    : null,
      valor_total_vendas: json['valor_total_vendas'] is int
          ? (json['valor_total_vendas'] as int).toDouble()
          : json['valor_total_vendas'] is double
              ? json['valor_total_vendas'] as double
              : 0.0,
      valor_total_devolucoes: json['valor_total_devolucoes'] is int
          ? (json['valor_total_devolucoes'] as int).toDouble()
          : json['valor_total_devolucoes'] is double
              ? json['valor_total_devolucoes'] as double
              : 0.0,
      valor_total_credito: json['valor_total_credito'] is int
          ? (json['valor_total_credito'] as int).toDouble()
          : json['valor_total_credito'] is double
              ? json['valor_total_credito'] as double
              : 0.0,
      qtde_vencido: json['qtde_vencido'],
      valor_vencido: json['valor_vencido'] is int
          ? (json['valor_vencido'] as int).toDouble()
          : json['valor_vencido'] is double
              ? json['valor_vencido'] as double
              : 0.0,
      valor_a_vencer: json['valor_a_vencer'] is int
          ? (json['valor_a_vencer'] as int).toDouble()
          : json['valor_a_vencer'] is double
              ? json['valor_a_vencer'] as double
              : 0.0,
      valor_devedor: json['valor_devedor'] is int
          ? (json['valor_devedor'] as int).toDouble()
          : json['valor_devedor'] is double
              ? json['valor_devedor'] as double
              : 0.0,
      limitecredito: json['limitecredito'] is int
          ? (json['limitecredito'] as int).toDouble()
          : json['limitecredito'] is double
              ? json['limitecredito'] as double
              : 0.0,
    );
  }
}

class DataServiceCustomerDetail {
  static Future<CustomerDetail>? fetchDataCustomerDetail(
      String url, String vendedorId) async {
    String? codigo;
    String? nome;
    dynamic? data_ultima_venda;
    dynamic? data_ultimo_pagamento;
    dynamic? valor_total_vendas;
    dynamic? valor_total_devolucoes;
    dynamic? valor_total_credito;
    dynamic? qtde_vencido;
    dynamic? valor_vencido;
    dynamic? valor_a_vencer;
    dynamic? valor_devedor;
    dynamic? limitecredito;
    try {
      var urlReq = Uri.parse(
          '''$url/ideia/core/getdata/vw_customer_detail%20WHERE%20pessoa_id%20=%20'$vendedorId'/''');
      var headers = ({'Accept': 'text/html'});
      print(urlReq);
      var response = await http.get(urlReq, headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var key = data['data'].keys.first;
        var list = data['data'][key];
        if (list != null) {
          codigo = list[0]['codigo'];
          nome = list[0]['nome'];
          data_ultima_venda = list[0]['data_ultima_venda'] != null ? DateTime.parse(list[0]['data_ultima_venda']) : null;
          data_ultimo_pagamento = list[0]['data_ultimo_pagamento'] != null ? DateTime.parse(list[0]['data_ultimo_pagamento']) : null;
          valor_total_vendas = list[0]['valor_total_vendas'];
          valor_total_devolucoes = list[0]['valor_total_devolucoes'];
          valor_total_credito = list[0]['valor_total_credito'];
          qtde_vencido = list[0]['qtde_vencido'];
          valor_vencido = list[0]['valor_vencido'];
          valor_a_vencer = list[0]['valor_a_vencer'];
          valor_devedor = list[0]['valor_devedor'];
          limitecredito = list[0]['limitecredito'];
        }
      }
    } catch (e) {
      print(e);
    }
    return CustomerDetail(
      codigo: codigo,
      nome: nome,
      data_ultima_venda: data_ultima_venda,
      data_ultimo_pagamento: data_ultimo_pagamento,
      valor_total_vendas: valor_total_vendas ?? 0.0,
      valor_total_devolucoes: valor_total_devolucoes ?? 0.0,
      valor_total_credito: valor_total_credito ?? 0.0,
      qtde_vencido: qtde_vencido,
      valor_vencido: valor_vencido ?? 0.0,
      valor_a_vencer: valor_a_vencer ?? 0.0,
      valor_devedor: valor_devedor ?? 0.0,
      limitecredito: limitecredito ?? 0.0,
    );
  }
}
