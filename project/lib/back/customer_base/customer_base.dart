import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomerBase {
  dynamic pessoaId;
  dynamic nome;
  dynamic codigo;
  dynamic valorcredito;
  dynamic cpf;
  dynamic cnpj;
  // dynamic datavencimento;
  // dynamic datapagamento;
  // dynamic flagquitado;
  dynamic titles;
  dynamic customers;
  dynamic defaulters;
  dynamic nonCompliant;
  dynamic open;

  CustomerBase(
      {this.pessoaId,
      this.nome,
      this.codigo,
      this.valorcredito,
      this.cpf,
      this.cnpj,
      // this.datavencimento,
      // this.datapagamento,
      // this.flagquitado,
      this.titles,
      this.customers,
      this.defaulters,
      this.nonCompliant,
      this.open});

  factory CustomerBase.fromJson(Map<String, dynamic> json) {
    return CustomerBase(
        pessoaId: json['pessoa_id'] ?? '',
        nome: json['nome'] ?? '',
        codigo: json['codigo'] ?? '',
        valorcredito: json['valorcredito'] is int
            ? (json['valorcredito'] as int).toDouble()
            : json['valorcredito'] is double
                ? json['valorcredito'] as double
                : 0.0,
        cpf: json['cpf'] ?? '',
        cnpj: json['cnpj'] ?? '',
        // datavencimento: json['datavencimento'] ?? '$search',
        // datapagamento: json['datapagamento'] ?? '$search',
        // flagquitado: json['flagquitado'] ?? 0,
        titles: json['total_titulos'],
        customers: [],
        defaulters: json['inadimplente'] ?? 0,
        nonCompliant: 0,
        open: json['em_aberto']);
  }
}

class DataServiceCustomers {
  static Future<CustomerBase>? fetchDataCustomers(
      String urlBasic, String vendedorId, String search) async {
    List<CustomerBase>? customers;
    int defaulters = 0;
    int nonCompliant = 0;
    List<CustomerBase> open = [];
    try {
      var urlGet = Uri.parse(
          '''$urlBasic/ideia/core/getdata/vw_pessoa_titulos%20WHERE%20vendedor_pessoa_id%20=%20'$vendedorId'/''');
      // '$search''$urlBasic/ideia/core/getdata/pessoa%20p%20LEFT%20JOIN%20titulo%20t%20ON%20t.pessoa_id%20=%20p.pessoa_id%20WHERE%20p.vendedor_pessoa_id%20=%20'$vendedorId'%20AND%20t.titulo_id%20IS%20NOT%20NULL/'$search'');
      var headers = ({"Accept": "text/html"});
      print(urlGet);
      var response = await http.get(urlGet, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var dynamicKey = jsonData['data'].keys.first;
        var dataList = jsonData['data'][dynamicKey];
        if (dataList != null && dataList is List) {
          if (search.isNotEmpty) {
            customers = dataList.map((e) => CustomerBase.fromJson(e)).toList();
            customers = customers
                .where((cliente) => cliente.nome.toLowerCase().contains(search) || cliente.codigo.toLowerCase().contains(search) || cliente.cpf.toLowerCase().contains(search) || cliente.cnpj.toLowerCase().contains(search))
                .toList();
            print(customers);
          } else {
            customers = dataList.map((e) => CustomerBase.fromJson(e)).toList();

            var inadimplentes = customers
                .where((customer) => customer.defaulters != 0)
                .toList();
            defaulters = inadimplentes.length;

            var adimplentes = customers
                .where((customer) => customer.defaulters == 0)
                .toList();
            nonCompliant = adimplentes.length;

            open = customers.where((customer) => customer.open != 0).toList();
          }
        } else {
          print('Lista não encontrada');
        }
      } else {
        print('Resposta não alcançada - ${response.body}');
      }
    } catch (e) {
      print('Erro durante a requisição Customers - $e');
    }
    return CustomerBase(
        customers: customers,
        defaulters: defaulters,
        nonCompliant: nonCompliant,
        open: open.length);
  }
}
