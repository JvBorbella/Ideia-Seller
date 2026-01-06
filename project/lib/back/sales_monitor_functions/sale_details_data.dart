import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/front/pages/sale_details_page.dart';

class SaleDetailsData {
  List<SaleDetailsData>? salesDetails;
  List<SaleDetailsData>? salesPayments;
  String? codigopessoa;
  String? nomepessoa;
  String? empresacodigo;
  String? empresanome;
  String? numero;
  String? numeromovimento;
  String? terminal;
  dynamic? valortotalmovimento;
  dynamic? valortotalprodutos;
  dynamic? valoroutrasdespesas;
  dynamic? valordescontomovimento;
  dynamic? valorfrete;
  String? tipopagamento;
  String? nomecondicaopagamento;
  dynamic? valorpagamento;
  String? codigoproduto;
  String? nomeproduto;
  dynamic? quantidadeproduto;
  String? expedicao;
  dynamic? valordescontoitem;
  dynamic? valortotalitem;
  dynamic? margem;

  SaleDetailsData(
      {this.salesDetails,
      this.salesPayments,
      this.codigopessoa,
      this.nomepessoa,
      this.empresacodigo,
      this.empresanome,
      this.numero,
      this.numeromovimento,
      this.terminal,
      this.valortotalmovimento,
      this.valortotalprodutos,
      this.valoroutrasdespesas,
      this.valordescontomovimento,
      this.valorfrete,
      this.tipopagamento,
      this.nomecondicaopagamento,
      this.valorpagamento,
      this.codigoproduto,
      this.nomeproduto,
      this.quantidadeproduto,
      this.expedicao,
      this.valordescontoitem,
      this.valortotalitem,
      this.margem});

  factory SaleDetailsData.fromJson(Map<String, dynamic> json) {
    return SaleDetailsData(
        codigopessoa: json['codigo'] ?? '',
        nomepessoa: json['nome'] ?? '',
        empresacodigo: json['empresa_codigo'] ?? '',
        empresanome: json['empresa_nome'] ?? '',
        numero: json['numero'] ?? '',
        numeromovimento: json['numeromovimento'] ?? '',
        terminal: json['terminal'] ?? '',
        valortotalmovimento: json['valortotal'] is int
            ? (json['valortotal'] as int).toDouble()
            : json['valortotal'] is double
                ? json['valortotal'] as double
                : 0.0,
        valortotalprodutos: json['valortotalprodutos'] is int
            ? (json['valortotalprodutos'] as int).toDouble()
            : json['valortotalprodutos'] is double
                ? json['valortotalprodutos'] as double
                : 0.0,
        valoroutrasdespesas: json['valoroutrasdespesas'] is int
            ? (json['valoroutrasdespesas'] as int).toDouble()
            : json['valoroutrasdespesas'] is double
                ? json['valoroutrasdespesas'] as double
                : 0.0,
        valordescontomovimento: json['valordesconto'] is int
            ? (json['valordesconto'] as int).toDouble()
            : json['valordesconto'] is double
                ? json['valordesconto'] as double
                : 0.0,
        valorfrete: json['valorfrete'] is int
            ? (json['valorfrete'] as int).toDouble()
            : json['valorfrete'] is double
                ? json['valorfrete'] as double
                : 0.0,
        //tipopagamento: json['tipopagamento'] ?? '',
        nomecondicaopagamento: json['nomecondicaopagamento'] ?? '',
        valorpagamento: json['valorpagamento'] is int
            ? (json['valorpagamento'] as int).toDouble()
            : json['valorpagamento'] is double
                ? json['valorpagamento'] as double
                : 0.0,
        codigoproduto: json['codigoproduto'] ?? '',
        nomeproduto: json['nomeproduto'] ?? '',
        quantidadeproduto: json['quantidadecomercial'] is int
            ? (json['quantidadecomercial'] as int).toDouble()
            : json['quantidadecomercial'] is double
                ? json['quantidadecomercial'] as double
                : 0.0,
        expedicao: json['nome_2'] ?? '',
        valordescontoitem: json['valordescontoitem'] is int
            ? (json['valordescontoitem'] as int).toDouble()
            : json['valordescontoitem'] is double
                ? json['valordescontoitem'] as double
                : 0.0,
        valortotalitem: json['valortotalproduto'] is int
            ? (json['valortotalproduto'] as int).toDouble()
            : json['valortotalproduto'] is double
                ? json['valortotalproduto'] as double
                : 0.0,
        margem: 0.0);
  }
}

class DataServiceSaleDetails {
  static Future<SaleDetailsData>? fetchDataSaleDetails(
      String url, String movimentosaidaId) async {
    List<SaleDetailsData>? details;
    List<SaleDetailsData>? payments;
    String? codigo;
    String? nome;
    String? empresacodigo;
    String? empresanome;
    String? numeropedido;
    String? numeromovimento;
    String? terminal;
    double? valortotal;
    double? subtotal;
    double? outrasdespesas;
    double? descontototal;
    double? frete;
    double? margem;

    String? nomecondicaopagamento;
    double? valorpagamento;
    try {
      var urlGet = Uri.parse(
          '''$url/ideia/core/getdata/movimentosaidaproduto%20mp%20LEFT%20JOIN%20movimentosaida%20m%20ON%20mp.movimentosaida_id%20=%20m.movimentosaida_id%20LEFT%20JOIN%20pessoa%20p%20ON%20p.pessoa_id%20=%20m.pessoa_id%20LEFT%20JOIN%20empresa%20e%20ON%20e.empresa_id%20=%20m.empresa_id%20LEFT%20JOIN%20expedicao%20ex%20ON%20ex.expedicao_id%20=%20mp.expedicao_id%20WHERE%20m.movimentosaida_id%20=%20'$movimentosaidaId'/''');
      var headers = {"Accept": "text/html"};
      var response = await http.get(urlGet, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var dynamicKey = jsonData['data'].keys.first;
        var dataList = jsonData['data'][dynamicKey];
        if (dataList is List && dataList.isNotEmpty) {
          details = dataList.map((e) => SaleDetailsData.fromJson(e)).toList();
          codigo = details.first.codigopessoa ?? '';
          nome = details.first.nomepessoa ?? '';
          empresacodigo = details.first.empresacodigo ?? '';
          empresanome = details.first.empresanome ?? '';
          numeropedido = details.first.numero ?? '';
          numeromovimento = details.first.numeromovimento ?? '';
          terminal = details.first.terminal ?? '';
          valortotal = details.first.valortotalmovimento ?? 0.0;
          subtotal = details.first.valortotalprodutos ?? 0.0;
          outrasdespesas = details.first.valoroutrasdespesas ?? 0.0;
          descontototal = details.first.valordescontomovimento ?? 0.0;
          frete = details.first.valorfrete ?? 0.0;
          margem = ((details.first.valortotalmovimento -
                      details.first.valordescontomovimento -
                      details.first.valoroutrasdespesas) /
                  details.first.valortotalmovimento) *
              100;
        }
      } else {
        print("Erro durante a consulta - ${response.body}");
      }
    } catch (e) {
      print('Erro na requisição SaleDetails: $e');
    }
    try {
      var urlGet = Uri.parse(
          '''$url/ideia/core/getdata/movimentosaidapagamento%20mp%20LEFT%20JOIN%20movimentosaida%20m%20ON%20mp.movimentosaida_id%20=%20m.movimentosaida_id%20WHERE%20m.movimentosaida_id%20=%20'$movimentosaidaId'/''');
      var headers = {"Accept": "text/html"};
      var response = await http.get(urlGet, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var dynamicKey = jsonData['data'].keys.first;
        var dataList = jsonData['data'][dynamicKey];
        if (dataList is List && dataList.isNotEmpty) {
          payments = dataList.map((e) => SaleDetailsData.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print('Erro na requisição payments: $e');
    }
    return SaleDetailsData(
        salesDetails: details,
        salesPayments: payments,
        codigopessoa: codigo,
        nomepessoa: nome,
        empresacodigo: empresacodigo,
        empresanome: empresanome,
        numero: numeropedido,
        numeromovimento: numeromovimento,
        terminal: terminal,
        valortotalmovimento: valortotal,
        valortotalprodutos: subtotal,
        valoroutrasdespesas: outrasdespesas,
        valordescontomovimento: descontototal,
        valorfrete: frete,
        margem: margem);
  }
}
