import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetSales {
  String? movimentosaida_id;
  String? vendedor_pessoa_id;
  String? numeromovimento;
  String? nomepessoa;
  String? nomecondicaopagamento;
  dynamic datacadastro;
  dynamic flagservico;
  dynamic flagcancelado;
  dynamic flagdevolucaovenda;
  dynamic valortotalprodutos;
  dynamic valordesconto;
  dynamic valortotal;
  dynamic ticketMedio;
  dynamic mediaDiaria;
  dynamic margem;
  dynamic devolucoes;
  dynamic cancelamentos;
  dynamic descontos;

  GetSales({
    required this.movimentosaida_id,
    required this.vendedor_pessoa_id,
    required this.numeromovimento,
    required this.nomepessoa,
    required this.nomecondicaopagamento,
    required this.datacadastro,
    required this.flagservico,
    required this.flagcancelado,
    required this.flagdevolucaovenda,
    required this.valortotalprodutos,
    required this.valordesconto,
    required this.valortotal,
    required this.ticketMedio,
    required this.mediaDiaria,
    required this.margem,
    required this.devolucoes,
    required this.cancelamentos,
    required this.descontos,
  });

  factory GetSales.fromJson(Map<String, dynamic> json) {
    return GetSales(
      movimentosaida_id: json['movimentosaida_id'] ?? '',
      vendedor_pessoa_id: json['vendedor_pessoa_id'] ?? '',
      numeromovimento: json['numeromovimento'] ?? '',
      nomepessoa: json['nomepessoa'] ?? '',
      nomecondicaopagamento: json['nomecondicaopagamento'] ?? '',
      datacadastro: json['datacadastro'] ?? '',
      flagservico: json['flagservico'] ?? 0,
      flagcancelado: json['flagcancelado'] ?? 0,
      flagdevolucaovenda: json['flagdevolucaovenda'] ?? 0,
      valortotalprodutos: json['valortotalprodutos'] is int
          ? (json['valortotalprodutos'] as int).toDouble()
          : json['valortotalprodutos'] is double
              ? json['valortotalprodutos'] as double
              : 0.0,
      valordesconto: json['valordesconto'] is int
          ? (json['valordesconto'] as int).toDouble()
          : json['valordesconto'] is double
              ? json['valordesconto'] as double
              : 0.0,
      valortotal: json['valortotal'] is int
          ? (json['valortotal'] as int).toDouble()
          : json['valortotal'] is double
              ? json['valortotal'] as double
              : 0.0,
      ticketMedio: 0.0,
      mediaDiaria: 0.0,
      margem: 0.0,
      devolucoes: 0.0,
      cancelamentos: 0.0,
      descontos: json['valortotaldescontoglobal'] is int
          ? (json['valortotaldescontoglobal'] as int).toDouble()
          : json['valortotaldescontoglobal'] is double
              ? json['valortotaldescontoglobal'] as double
              : 0.0,
    );
  }
}

class SalesResult {
  final List<GetSales> sales;
  final double totalToday;
  final double totalYesterday;
  final double totalWeek;
  final double totalMonth;
  final double totalPrevMonth;
  final double totalCancelPrevMonth;

  SalesResult(
      {required this.sales,
      required this.totalToday,
      required this.totalYesterday,
      required this.totalWeek,
      required this.totalMonth,
      required this.totalPrevMonth,
      required this.totalCancelPrevMonth});

  static Future<SalesResult?> fetchDataSales(
      String url, String usuarioId) async {
    List<GetSales> salesList = [];
    // T O D A Y
    double totalVendasHoje = 0.0;
    double valueLiquidToday = 0.0;
    // Y E S T E R D A Y
    double totalVendasOntem = 0.0;
    double valueLiquidYesterday = 0.0;
    // W E E K
    double totalVendasSemana = 0.0;
    double valueLiquidWeek = 0.0;
    //M O N T H
    double totalVendasMes = 0.0;
    double valueLiquidMonth = 0.0;
    //P R E V  M O N T H
    double totalVendasMesAnterior = 0.0;
    double valueLiquidPrevMonth = 0.0;

    double valueReturns = 0.0;
    double valueCancelations = 0.0;
    double valueDiscount = 0.0;
    double valueLiquid = 0.0;

    // T O D A Y
    try {
      var urlToday = Uri.parse(
          '''$url/ideia/core/getdata/movimentosaida%20m%20LEFT%20JOIN%20movimentosaidapagamento%20mp%20ON%20mp.movimentosaida_id%20=%20m.movimentosaida_id%20LEFT%20JOIN%20movimentoentrada%20me%20ON%20me.ref_movimentosaida_id%20=%20m.movimentosaida_id%20WHERE%20m.vendedor_pessoa_id%20=%20'$usuarioId'%20AND%20m.data%20=%20CURRENT_DATE/''');
      var headers = ({"Accept": "text/html"});
      var response = await http.get(urlToday, headers: headers);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          var dynamicKey = jsonData['data'].keys.first;
          var list = jsonData['data'][dynamicKey];
          if (list != null && list is List) {
            salesList = list.map((e) => GetSales.fromJson(e)).toList();
            valueCancelations = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagcancelado == 1 ? (item.valortotal ?? 0.0) : 0.0));
            valueReturns = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagdevolucaovenda == 1
                        ? (item.valortotal ?? 0.0)
                        : 0.0));
            valueDiscount = salesList.fold(
                0.0, (sum, item) => sum + (item.valordesconto ?? 0.0));
            totalVendasHoje = salesList.fold(
                0.0, (sum, item) => sum + (item.valortotal ?? 0.0));
            var subtration = valueDiscount + valueCancelations + valueReturns;
            valueLiquidToday = salesList.fold(
                0.0, (sum, item) => totalVendasHoje - subtration);
          }
        } else {
          print("Sem registros de vendas encontrados");
        }
      } else {
        print('Não bateu 200 - ${response.body}');
      }
    } catch (e) {
      print('Erro durante a requisição Sales - $e');
    }
    // Y E S T E R D A Y
    try {
      var urlYesterday = Uri.parse(
          '''$url/ideia/core/getdata/movimentosaida%20m%20LEFT%20JOIN%20movimentosaidapagamento%20mp%20ON%20mp.movimentosaida_id%20=%20m.movimentosaida_id%20LEFT%20JOIN%20movimentoentrada%20me%20ON%20me.ref_movimentosaida_id%20=%20m.movimentosaida_id%20WHERE%20m.vendedor_pessoa_id%20=%20'$usuarioId'%20AND%20m.data%20=%20CURRENT_DATE%20-%201/''');
      var headers = ({"Accept": "text/html"});
      var response = await http.get(urlYesterday, headers: headers);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          var dynamicKey = jsonData['data'].keys.first;
          var list = jsonData['data'][dynamicKey];
          if (list != null && list is List) {
            salesList = list.map((e) => GetSales.fromJson(e)).toList();
            valueCancelations = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagcancelado == 1 ? (item.valortotal ?? 0.0) : 0.0));
            valueReturns = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagdevolucaovenda == 1
                        ? (item.valortotal ?? 0.0)
                        : 0.0));
            valueDiscount = salesList.fold(
                0.0, (sum, item) => sum + (item.valordesconto ?? 0.0));
            totalVendasOntem = salesList.fold(
                0.0, (sum, item) => sum + (item.valortotal ?? 0.0));
            var subtration = valueDiscount + valueCancelations + valueReturns;
            valueLiquidYesterday = salesList.fold(
                0.0, (sum, item) => totalVendasOntem - subtration);
          }
        } else {
          print("Sem registros de vendas encontrados");
        }
      } else {
        print('Não bateu 200 - ${response.body}');
      }
    } catch (e) {
      print('Erro durante a requisição Sales - $e');
    }
    // W E E K
    try {
      var urlWeek = Uri.parse(
          '''$url/ideia/core/getdata/movimentosaida%20m%20LEFT%20JOIN%20movimentosaidapagamento%20mp%20ON%20mp.movimentosaida_id%20=%20m.movimentosaida_id%20LEFT%20JOIN%20movimentoentrada%20me%20ON%20me.ref_movimentosaida_id%20=%20m.movimentosaida_id%20WHERE%20m.vendedor_pessoa_id%20=%20'$usuarioId'%20AND%20m.data%20%3E=%20ADDDATE(CURDATE(),INTERVAL%20(DAYOFWEEK(CURDATE())-1)*(-1)%20day)/''');
      var headers = ({"Accept": "text/html"});
      var response = await http.get(urlWeek, headers: headers);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          var dynamicKey = jsonData['data'].keys.first;
          var list = jsonData['data'][dynamicKey];
          if (list != null && list is List) {
            salesList = list.map((e) => GetSales.fromJson(e)).toList();
            valueCancelations = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagcancelado == 1 ? (item.valortotal ?? 0.0) : 0.0));
            valueReturns = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagdevolucaovenda == 1
                        ? (item.valortotal ?? 0.0)
                        : 0.0));
            valueDiscount = salesList.fold(
                0.0, (sum, item) => sum + (item.valordesconto ?? 0.0));
            totalVendasSemana = salesList.fold(
                0.0, (sum, item) => sum + (item.valortotal ?? 0.0));
            var subtration = valueDiscount + valueCancelations + valueReturns;
            valueLiquidWeek = salesList.fold(
                0.0, (sum, item) => totalVendasSemana - subtration);
          }
        } else {
          print("Sem registros de vendas encontrados");
        }
      } else {
        print('Não bateu 200 - ${response.body}');
      }
    } catch (e) {
      print('Erro durante a requisição Sales - $e');
    }
    // M O N T H
    try {
      var urlGet = Uri.parse(
          '''$url/ideia/core/getdata/movimentosaida%20m%20LEFT%20JOIN%20movimentosaidapagamento%20mp%20ON%20mp.movimentosaida_id%20=%20m.movimentosaida_id%20LEFT%20JOIN%20movimentoentrada%20me%20ON%20me.ref_movimentosaida_id%20=%20m.movimentosaida_id%20WHERE%20m.vendedor_pessoa_id%20=%20'$usuarioId'%20AND%20m.data%20%3E=%20ADDDATE(CURDATE(),INTERVAL%20(DAYOFMONTH(CURDATE())-1)*(-1)%20day)/''');
      var headers = ({"Accept": "text/html"});
      var response = await http.get(urlGet, headers: headers);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          var dynamicKey = jsonData['data'].keys.first;
          var list = jsonData['data'][dynamicKey];
          if (list != null && list is List) {
            salesList = list.map((e) => GetSales.fromJson(e)).toList();
            valueCancelations = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagcancelado == 1 ? (item.valortotal ?? 0.0) : 0.0));
            valueReturns = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagdevolucaovenda == 1
                        ? (item.valortotal ?? 0.0)
                        : 0.0));
            valueDiscount = salesList.fold(
                0.0, (sum, item) => sum + (item.valordesconto ?? 0.0));
            totalVendasMes = salesList.fold(
                0.0, (sum, item) => sum + (item.valortotal ?? 0.0));
            var subtration = valueDiscount + valueCancelations + valueReturns;
            valueLiquidMonth =
                salesList.fold(0.0, (sum, item) => totalVendasMes - subtration);
          }
        } else {
          print("Sem registros de vendas encontrados");
        }
      } else {
        print('Não bateu 200 - ${response.body}');
      }
    } catch (e) {
      print('Erro durante a requisição Sales - $e');
    }
    // P R E V  M O N T H
    try {
      var urlGet = Uri.parse(
          '''$url/ideia/core/getdata/movimentosaida%20m%20LEFT%20JOIN%20movimentosaidapagamento%20mp%20ON%20mp.movimentosaida_id%20=%20m.movimentosaida_id%20LEFT%20JOIN%20movimentoentrada%20me%20ON%20me.ref_movimentosaida_id%20=%20m.movimentosaida_id%20WHERE%20m.vendedor_pessoa_id%20=%20'$usuarioId'%20AND%20m.data%20%3E=%20DATE_FORMAT(CURDATE()%20-%20INTERVAL%201%20MONTH,%20'%Y-%m-01')%20AND%20m.data%20%3C=%20LAST_DAY(CURDATE()%20-%20INTERVAL%201%20MONTH)/''');
      var headers = ({"Accept": "text/html"});
      var response = await http.get(urlGet, headers: headers);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          var dynamicKey = jsonData['data'].keys.first;
          var list = jsonData['data'][dynamicKey];
          if (list != null && list is List) {
            salesList = list.map((e) => GetSales.fromJson(e)).toList();
            valueCancelations = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagcancelado == 1 ? (item.valortotal ?? 0.0) : 0.0));
            valueReturns = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagdevolucaovenda == 1
                        ? (item.valortotal ?? 0.0)
                        : 0.0));
            valueDiscount = salesList.fold(
                0.0, (sum, item) => sum + (item.valordesconto ?? 0.0));
            totalVendasMesAnterior = salesList.fold(
                0.0, (sum, item) => sum + (item.valortotal ?? 0.0));
            var subtration = valueDiscount + valueCancelations + valueReturns;
            valueLiquidPrevMonth = salesList.fold(
                0.0, (sum, item) => totalVendasMesAnterior - subtration);
          }
        } else {
          print("Sem registros de vendas encontrados");
        }
      } else {
        print('Não bateu 200 - ${response.body}');
      }
    } catch (e) {
      print('Erro durante a requisição Sales - $e');
    }
    return SalesResult(
        sales: salesList,
        totalToday: valueLiquidToday,
        totalYesterday: valueLiquidYesterday,
        totalWeek: valueLiquidWeek,
        totalMonth: valueLiquidMonth,
        totalPrevMonth: valueLiquidPrevMonth,
        totalCancelPrevMonth: valueLiquid);
  }
}

// -----------------------------------------------------------------------------

class SalesResultValues {
  final List<GetSales> sales;
  final double totalValueGross;
  final double totalValueLiquid;
  final double averageTicket;
  final double dailyAverage;
  final double margin;
  final double returns;
  final double cancellations;
  final double discounts;

  SalesResultValues({
    required this.sales,
    required this.totalValueGross,
    required this.totalValueLiquid,
    required this.averageTicket,
    required this.dailyAverage,
    required this.margin,
    required this.returns,
    required this.cancellations,
    required this.discounts,
  });

  static Future<SalesResultValues?> fetchDataSales(String url, String usuarioId,
      String period, int flagfilter, String search) async {
    List<GetSales> salesList = [];
    double totalValueGross = 0.0;
    double totalValueLiquid = 0.0;
    double averageTicket = 0.0;
    double dailyAverage = 0.0;
    double margin = 0.0;
    double returns = 0.0;
    double cancellations = 0.0;
    double discounts = 0.0;
    // A L L
    try {
      var urlSalesData = Uri.parse(
          '''$url/ideia/core/getdata/movimentosaida%20m%20LEFT%20JOIN%20movimentosaidapagamento%20mp%20ON%20mp.movimentosaida_id%20=%20m.movimentosaida_id%20LEFT%20JOIN%20movimentoentrada%20me%20ON%20me.ref_movimentosaida_id%20=%20m.movimentosaida_id%20WHERE%20m.vendedor_pessoa_id%20=%20'$usuarioId'%20AND%20$period/''');
      var headers = ({"Accept": "text/html"});
      var response = await http.get(urlSalesData, headers: headers);
      print(urlSalesData);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success'] == 1) {
          var dynamicKey = jsonData['data'].keys.first;
          var list = jsonData['data'][dynamicKey];
          if (list != null && list is List) {
            //salesList = list.map((e) => GetSales.fromJson(e)).toList();
            switch (flagfilter) {
              case 1:
                salesList = list.map((e) => GetSales.fromJson(e)).toList();
                salesList = salesList
                    .where((sales) =>
                        sales.flagcancelado == 1)
                    .toList();
                salesList = salesList
                    .where((sales) =>
                        sales.numeromovimento!.toLowerCase().contains(search) ||
                        sales.nomepessoa!.toLowerCase().contains(search))
                    .toList();
              case 2:
                salesList = list.map((e) => GetSales.fromJson(e)).toList();
                salesList = salesList
                    .where((sales) =>
                        sales.flagdevolucaovenda == 1)
                    .toList();
                salesList = salesList
                    .where((sales) =>
                        sales.numeromovimento!.toLowerCase().contains(search) ||
                        sales.nomepessoa!.toLowerCase().contains(search))
                    .toList();
              case 3:
                salesList = list.map((e) => GetSales.fromJson(e)).toList();
                salesList = salesList
                    .where((sales) =>
                        sales.flagdevolucaovenda != 1 &&
                            sales.flagcancelado != 1).toList();
                salesList = salesList
                    .where((sales) =>
                        sales.numeromovimento!.toLowerCase().contains(search) ||
                        sales.nomepessoa!.toLowerCase().contains(search))
                    .toList();
              case 4:
                salesList = list.map((e) => GetSales.fromJson(e)).toList();
                salesList = salesList
                    .where((sales) =>
                        sales.numeromovimento!.toLowerCase().contains(search) ||
                        sales.nomepessoa!.toLowerCase().contains(search))
                    .toList();
            }
            totalValueGross = salesList.fold(
                0.0, (sum, item) => sum + (item.valortotal));
            discounts = salesList.fold(
                0.0, (sum, item) => sum + (item.descontos ?? 0.0));
            returns = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagdevolucaovenda == 1
                        ? (item.valortotal ?? 0.0)
                        : 0.0));
            cancellations = salesList.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (item.flagcancelado == 1 ? (item.valortotal ?? 0.0) : 0.0));
            var subtration = discounts + cancellations + returns;
            totalValueLiquid = salesList.fold(
                0.0, (sum, item) => totalValueGross - subtration);
            averageTicket = totalValueLiquid / salesList.length;
            dailyAverage = totalValueLiquid / period.length;
            margin = (totalValueLiquid / totalValueGross) * 100;
          }
        } else {
          print("Sem registros de vendas encontrados");
        }
      } else {
        print('Não bateu 200 - ${response.body}');
      }
    } catch (e) {
      print('Erro durante a requisição Sales - $e');
    }
    return SalesResultValues(
      sales: salesList,
      totalValueGross: totalValueGross,
      totalValueLiquid: totalValueLiquid,
      averageTicket: averageTicket,
      dailyAverage: dailyAverage,
      margin: margin,
      cancellations: cancellations,
      returns: returns,
      discounts: discounts,
    );
  }
}
