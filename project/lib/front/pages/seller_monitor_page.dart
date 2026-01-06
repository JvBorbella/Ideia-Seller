import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/back/customer_base/customer_base.dart';
import 'package:project/back/objectives.dart';
import 'package:project/back/sdui.dart';
import 'package:project/back/seller_monitor/sales.dart';
import 'package:project/back/seller_monitor/seller_monitor_data.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/sdui_render.dart';
import 'package:project/front/components/structure/form_card.dart';
import 'package:project/front/components/structure/interactive_card.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/components/texts/titles.dart';
import 'package:project/front/pages/customer_portifolio_page.dart';
import 'package:project/front/pages/sale_monitor_page.dart';
import 'package:project/front/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<SellerMonitorPageState> sellerPageKey =
    GlobalKey<SellerMonitorPageState>();

class SellerMonitorPage extends StatefulWidget {
  final userController;
  final vendedorId;
  final codigo;
  final nome;
  final imagemUrl;

  const SellerMonitorPage(
      {Key? key,
      this.userController,
      this.vendedorId,
      this.codigo,
      this.nome,
      this.imagemUrl});

  @override
  State<SellerMonitorPage> createState() => SellerMonitorPageState();
}

class SellerMonitorPageState extends State<SellerMonitorPage> {
  final ValueNotifier<double> monthValueNotifier = ValueNotifier<double>(0.0);

  String vendedorId = '',
      usuario = '',
      imageUserPath = '',
      urlBasic = '',
      period =
          '''m.data%20%3E=%20DATE_FORMAT(CURDATE()%20-%20INTERVAL%201%20MONTH,%20'%Y-%m-01')%20AND%20m.data%20%3C=%20LAST_DAY(CURDATE()%20-%20INTERVAL%201%20MONTH)''';
  double todayValue = 0.0,
      yesterdayValue = 0.0,
      weekValue = 0.0,
      monthValue = 0.0,
      prevMonthValue = 0.0;

  double vendabruta = 0.0,
      vendaliquida = 0.0,
      ticketmedio = 0.0,
      mediadiaria = 0.0,
      margem = 0.0,
      valortotaldevolucao = 0.0,
      valortotalcancelamento = 0.0,
      valortotaldesconto = 0.0,
      valortotal = 0.0,
      valortotalliquido = 0.0;

  int defaulters = 0, nonCompliant = 0, open = 0, flagFilter = 4;

  late String pessoa_id = '';
  late String codigo = '';
  late String nome = '';
  late String email = '';
  late String empresa_id = '';
  late String empresa_codigo = '';
  late String empresa_nome = '';
  late String imagem = '';
  late double vendashoje = 0.0;
  late double vendasontem = 0.0;
  late double vendassemana = 0.0;
  late double vendasmes = 0.0;
  late double vendasmesanterior = 0.0;
  late int clientes_inadimplentes = 0;
  late int clientes_adimplentes = 0;
  late int clientes_restantes = 0;

  bool isLoading = true;

  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: '');

  NumberFormat currencyFormatDefault =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  List<GetSales> sales = [];

  late Future<Map<String, dynamic>> sduiLayoutFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sduiLayoutFuture = SDUIService.fetchLayout();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Container(
              height: Style.CircularProgressIndicatorWidth(context),
              width: Style.CircularProgressIndicatorWidth(context),
              child: CircularProgressIndicator(
                year2023: true,
                strokeWidth: Style.CircularProgressIndicatorSize(context),
              )),
        ),
      );
    }
    return SafeArea(
        child: WillPopScope(
            child: Scaffold(
                drawer: Drawer(
                  child: CustomDrawer(),
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
                body: RefreshIndicator(
                    onRefresh: () => _refreshData(),
                    strokeWidth: Style.CircularProgressIndicatorSize(context),
                    child: ListView(
                      children: [
                        Navbar(
                          text: 'Monitor do Vendedor',
                          children: [
                            DrawerButton(
                              style: ButtonStyle(
                                  iconSize: WidgetStatePropertyAll(
                                      Style.SizeDrawerButton(context)),
                                  iconColor: WidgetStatePropertyAll(
                                      Style.tertiaryColor),
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.all(
                                          Style.PaddingDrawerButton(context)))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Style.height_15(context),
                        ),
                        CircleAvatar(
                          backgroundColor: Style.disabledColor,
                          maxRadius: Style.height_80(context),
                          // foregroundImage: AssetImage('assets/images/user.jpg'),
                          child: ClipOval(
                            child: imageUserPath.isEmpty
                                ? Image.asset(
                                    'assets/images/user.png',
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  )
                                : Image.network(
                                    '$urlBasic$imageUserPath',
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: Style.height_15(context),
                        ),
                        Titles(
                          text: codigo,
                          fontSize: Titles.h3(context),
                        ),
                        // FutureBuilder<String>(
                        //   future: fetchSellerData(),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return Titles(
                        //           text: 'Carregando...',
                        //           fontSize: Titles.h3(context));
                        //     } else if (snapshot.hasError) {
                        //       return Titles(
                        //           text: 'Erro ao carregar',
                        //           fontSize: Titles.h3(context));
                        //     } else {
                        //       return Titles(
                        //           text: snapshot.data ?? '',
                        //           fontSize: Titles.h3(context));
                        //     }
                        //   },
                        // ),
                        // Container(
                        //   child: Mirai.fromNetwork(
                        //     context: context,
                        //     loadingWidget: (context) => Container(
                        //         width: Style.width_80(context),
                        //           child: LinearProgressIndicator(
                        //             year2023: false,
                        //           )),
                        //     request: MiraiNetworkRequest(
                        //         url:'http://licenciamento.ideiatecnologia.com.br:8997/ideia/public/seller_data_list.json',
                        //         method: Method.post)),
                        // ),

                        // MiraiApp(
                        //   homeBuilder: (context) => Mirai.fromNetwork(
                        //     context: context,
                        //     request: MiraiNetworkRequest(
                        //       url: 'http://licenciamento.ideiatecnologia.com.br:8997/ideia/public/seller_data_list.json',
                        //       method: Method.post
                        //     )
                        // )
                        // ),
                        Titles(
                          text: nome,
                          fontSize: Titles.h3(context),
                        ),
                        SizedBox(
                          height: Style.height_15(context),
                        ),
                        InteractiveCard(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCard(
                                      text: 'Hoje',
                                      fontSize: Style.height_12(context),
                                      textAlign: TextAlign.left,
                                    ),
                                    TextCard(
                                      text: 'Ontem',
                                      fontSize: Style.height_12(context),
                                      textAlign: TextAlign.left,
                                    ),
                                    TextCard(
                                      text: 'Semana',
                                      fontSize: Style.height_12(context),
                                      textAlign: TextAlign.left,
                                    ),
                                    TextCard(
                                      text: 'Mês',
                                      fontSize: Style.height_12(context),
                                      textAlign: TextAlign.left,
                                    ),
                                    TextCard(
                                      text: 'Mês anterior',
                                      fontSize: Style.height_12(context),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextCard(
                                      text: currencyFormat
                                          .format(todayValue)
                                          .toString(),
                                      fontSize: Style.height_12(context),
                                      textAlign: TextAlign.right,
                                      FontWeight: FontWeight.bold,
                                    ),
                                    TextCard(
                                      text: currencyFormat
                                          .format(yesterdayValue)
                                          .toString(),
                                      fontSize: Style.height_12(context),
                                      textAlign: TextAlign.right,
                                      FontWeight: FontWeight.bold,
                                    ),
                                    TextCard(
                                      text: currencyFormat
                                          .format(weekValue)
                                          .toString(),
                                      fontSize: Style.height_12(context),
                                      textAlign: TextAlign.right,
                                      FontWeight: FontWeight.bold,
                                    ),
                                    TextCard(
                                      text: currencyFormat
                                          .format(monthValue)
                                          .toString(),
                                      fontSize: Style.height_12(context),
                                      textAlign: TextAlign.right,
                                      FontWeight: FontWeight.bold,
                                    ),
                                    TextCard(
                                      text: currencyFormat
                                          .format(prevMonthValue)
                                          .toString(),
                                      fontSize: Style.height_12(context),
                                      textAlign: TextAlign.right,
                                      FontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                          Text: 'Vendas ',
                          icon: Icons.monetization_on,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SaleMonitor(
                                    vendedorpessoa_id: vendedorId,
                                    ticketmedio: ticketmedio,
                                    mediadiaria: mediadiaria,
                                    margem: margem,
                                    valortotaldevolucao: valortotaldevolucao,
                                    valortotalcancelamento:
                                        valortotalcancelamento,
                                    valortotaldesconto: valortotaldesconto,
                                    valortotal: valortotal,
                                    valortotalliquido: valortotalliquido,
                                    valorHoje: todayValue,
                                    valorMes: monthValue,
                                    valorMesAnt: prevMonthValue),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: Style.height_10(context),
                        ),
                        InteractiveCard(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCard(
                                      text: 'Inadimplentes',
                                      fontSize: Style.height_12(context),
                                    ),
                                    TextCard(
                                      text: 'Adimplentes',
                                      fontSize: Style.height_12(context),
                                    ),
                                    TextCard(
                                      text: 'Títulos em aberto',
                                      fontSize: Style.height_12(context),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextCard(
                                      text: defaulters.toString(),
                                      fontSize: Style.height_12(context),
                                      FontWeight: FontWeight.bold,
                                    ),
                                    TextCard(
                                      text: nonCompliant.toString(),
                                      fontSize: Style.height_12(context),
                                      FontWeight: FontWeight.bold,
                                    ),
                                    TextCard(
                                      text: open.toString(),
                                      fontSize: Style.height_12(context),
                                      FontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                          Text: 'Carteira de Clientes',
                          icon: Icons.person_2_sharp,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => CustomerPortifolioPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: Style.height_10(context),
                        ),
                        InteractiveCard(
                          children: [
                            FutureBuilder<Map<String, dynamic>>(
                              future: fetchLayout(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }

                                return buildWidgetFromJson(snapshot.data!);
                              },
                            )

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Column(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         TextCard(
                            //           text: 'Meta Diária',
                            //           fontSize: Style.height_8(context),
                            //           color: Style.quarantineColor,
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           TextCard(
                            //             text: '5.000',
                            //             fontSize: Style.height_12(context),
                            //             FontWeight: FontWeight.bold,
                            //           ),
                            //         ],
                            //       ),
                            //       Column(
                            //         crossAxisAlignment: CrossAxisAlignment.end,
                            //         children: [
                            //           Icon(
                            //             Icons.check_circle,
                            //             color: todayValue >= 5000
                            //                 ? Style.sucefullColor
                            //                 : Style.tertiaryColor,
                            //             size: Style.height_12(context),
                            //           ),
                            //         ],
                            //       ),
                            //     ]),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Column(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         TextCard(
                            //           text: 'Meta Mensal',
                            //           fontSize: Style.height_8(context),
                            //           color: Style.quarantineColor,
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           TextCard(
                            //             text: '150.000',
                            //             fontSize: Style.height_12(context),
                            //             FontWeight: FontWeight.bold,
                            //           ),
                            //         ],
                            //       ),
                            //       Column(
                            //         crossAxisAlignment: CrossAxisAlignment.end,
                            //         children: [
                            //           Icon(
                            //             Icons.check_circle,
                            //             color: monthValue >= 150000
                            //                 ? Style.sucefullColor
                            //                 : Style.tertiaryColor,
                            //             size: Style.height_12(context),
                            //           ),
                            //         ],
                            //       ),
                            //     ]),
                          ],
                          Text: 'Metas de Venda',
                          // icon: Icons.track_changes_outlined,
                        ),
                        SizedBox(
                          height: Style.height_10(context),
                        )
                      ],
                    ))),
            onWillPop: () async {
              return false;
            }));
  }

  List<Widget> _buildChildren(Map<String, dynamic> json) {
    if (json['children'] == null) return [];

    return (json['children'] as List)
        .map<Widget>(
            (child) => buildWidgetFromJson(child as Map<String, dynamic>))
        .toList();
  }

  MainAxisAlignment _parseMainAxisAlignment(String? value) {
    switch (value) {
      case 'spaceBetween':
        return MainAxisAlignment.spaceBetween;
      case 'spaceAround':
        return MainAxisAlignment.spaceAround;
      case 'center':
        return MainAxisAlignment.center;
      case 'end':
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.start;
    }
  }

  Color? _parseColor(String? hex) {
    if (hex == null) return null;

    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';

    return Color(int.parse(hex, radix: 16));
  }

  TextStyle? _parseTextStyle(Map<String, dynamic>? json) {
    if (json == null) return null;

    return TextStyle(
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      fontWeight:
          json['fontWeight'] == 'bold' ? FontWeight.bold : FontWeight.normal,
      color: _parseColor(json['color']),
    );
  }

  IconData _parseIconData(String? name) {
    switch (name) {
      case 'check_circle':
        return Icons.check_circle;
      case 'error':
        return Icons.error;
      case 'warning':
        return Icons.warning;
      default:
        return Icons.help_outline;
    }
  }

  Widget buildWidgetFromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'Column':
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildChildren(json),
        );

      case 'Row':
        return Row(
          mainAxisAlignment: _parseMainAxisAlignment(json['mainAxisAlignment']),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildChildren(json),
        );

      case 'Text':
        return Text(
          json['data'] ?? '',
          style: _parseTextStyle(json['style']),
        );

      case 'Icon':
        return Icon(
          _parseIconData(json['icon']),
          color: _parseColor(json['color']),
          size: (json['size'] as num?)?.toDouble(),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
  }

  Future<void> _loadSavedUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUser = await sharedPreferences.getString('saveUser') ?? '';
    setState(() {
      usuario = savedUser;
    });
  }

  Future<void> _loadSavedSellerId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedVendedorId =
        await sharedPreferences.getString('vendedor_id') ?? '';
    setState(() {
      vendedorId = savedVendedorId;
    });
  }

  Future<void> _loadSavedImageUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedImageUser = await sharedPreferences.getString('image') ?? '';
    setState(() {
      imageUserPath = savedImageUser;
    });
  }

  Future<void> _loadSavedCodeSeller() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedCodeSeller = await sharedPreferences.getString('codigo') ?? '';
    setState(() {
      codigo = savedCodeSeller;
    });
  }

  Future<void> _loadSavedNameSeller() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedNameSeller = await sharedPreferences.getString('nome') ?? '';
    setState(() {
      nome = savedNameSeller;
    });
  }

  Future<void> loadData() async {
    await Future.wait([_loadSavedUrlBasic()]);
    await Future.wait([
      _loadSavedSellerId(),
      _loadSavedCodeSeller(),
      _loadSavedNameSeller(),
      _loadSavedUser(),
      _loadSavedImageUser()
    ]);
    // await Future.wait([fetchDataSellerMonitor()]);
    // await Future.wait([fetchSellerData()]);
    await Future.wait([fetchDataSales(period)]);
    await Future.wait([fetchDataCustomer()]);
    await Future.wait([fetchLayout()]);
    setState(() {
      isLoading = false;
    });
    print(todayValue);
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading =
          true; // Define isLoading como true para mostrar o indicador de carregamento
    });
    await loadData();
    setState(() {
      isLoading =
          false; // Define isLoading como false para parar o indicador de carregamento
    });
  }

  // Future<String> fetchSellerData() async {
  //   final response = await http.post(
  //     Uri.parse(
  //         'http://licenciamento.ideiatecnologia.com.br:8997/ideia/public/seller_data.json'),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return data['value'] ??
  //         'Nome não encontrado'; // Substitua pelo campo correto do JSON
  //   } else {
  //     throw Exception('Erro ao buscar dados');
  //   }
  // }

  Future<void> fetchDataSales(String period) async {
    final fetchData = await SalesResult.fetchDataSales(urlBasic, vendedorId);
    if (fetchData != null) {
      setState(() {
        sales = fetchData.sales;
        todayValue = fetchData.totalToday ?? 0.0;
        yesterdayValue = fetchData.totalYesterday ?? 0.0;
        weekValue = fetchData.totalWeek ?? 0.0;
        monthValue = fetchData.totalMonth ?? 0.0;
        prevMonthValue = fetchData.totalPrevMonth ?? 0.0;

        monthValue = fetchData.totalMonth ?? 0.0;
      });
      monthValueNotifier.value = monthValue;
    } else {
      print("Bigode - $fetchData");
    }
    final fetchDataPrevMonth = await SalesResultValues.fetchDataSales(
        urlBasic, vendedorId, period, flagFilter, '');
    if (fetchDataPrevMonth != null) {
      setState(() {
        valortotal = fetchDataPrevMonth.totalValueGross;
        valortotalliquido = fetchDataPrevMonth.totalValueLiquid;
        valortotaldesconto = fetchDataPrevMonth.discounts;
        valortotaldevolucao = fetchDataPrevMonth.returns;
        valortotalcancelamento = fetchDataPrevMonth.cancellations;
        ticketmedio = fetchDataPrevMonth.averageTicket;
        mediadiaria = fetchDataPrevMonth.dailyAverage;
        margem = fetchDataPrevMonth.margin;
      });
    }
  }

  static Future<Map<String, dynamic>> fetchLayout() async {
    final response = await http.get(
      Uri.parse(
        'http://licenciamento.ideiatecnologia.com.br:8997/ideia/public/goals_seller_monitor.json',
      ),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro HTTP: ${response.statusCode}');
    }

    final decodedBody = latin1.decode(response.bodyBytes);

    try {
      return jsonDecode(decodedBody) as Map<String, dynamic>;
    } catch (e) {
      print('JSON inválido recebido:');
      print(decodedBody);
      rethrow;
    }
  }

  Future<void> fetchDataCustomer() async {
    final fetchData =
        await DataServiceCustomers.fetchDataCustomers(urlBasic, vendedorId, '');
    if (fetchData != null) {
      setState(() {
        defaulters = fetchData.defaulters;
        nonCompliant = fetchData.nonCompliant;
        open = fetchData.open;
      });
    }
  }
}
