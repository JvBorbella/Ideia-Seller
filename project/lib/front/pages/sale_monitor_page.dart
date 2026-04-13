import 'dart:convert';
import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/back/sales_monitor_functions/sale_monitor_data.dart';
import 'package:project/back/seller_monitor/sales.dart';
import 'package:project/front/components/buttons/action_button.dart';
import 'package:project/front/components/buttons/custom_button.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/buttons/navbar_button.dart';
import 'package:project/front/components/structure/informative_card.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/components/texts/titles.dart';
import 'package:project/front/pages/sale_list_page.dart';
import 'package:project/front/pages/seller_monitor_page.dart';
import 'package:project/front/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SaleMonitor extends StatefulWidget {
  final vendedorpessoa_id;
  final ticketmedio;
  final mediadiaria;
  final margem;
  final valortotaldevolucao;
  final valortotalcancelamento;
  final valortotaldesconto;
  final valortotal;
  final valortotalliquido;
  final valorHoje;
  final valorMes;
  final valorMesAnt;

  const SaleMonitor(
      {Key? key,
      this.vendedorpessoa_id,
      this.ticketmedio,
      this.mediadiaria,
      this.margem,
      this.valortotaldevolucao,
      this.valortotalcancelamento,
      this.valortotaldesconto,
      this.valortotal,
      this.valortotalliquido,
      this.valorHoje,
      this.valorMes,
      this.valorMesAnt});

  @override
  State<SaleMonitor> createState() => _SaleMonitorState();
}

class _SaleMonitorState extends State<SaleMonitor> {
  String urlBasic = '',
      selectedOptionChild = '',
      vendedorId = '',
      period = 'm.data%20=%20CURRENT_DATE';
  int flagToday = 0,
      flagYesterday = 0,
      flagWeek = 0,
      flagMonth = 0,
      flagFilter = 4;
  bool isLoading = true, flagLoadingData = false;

  double vendabruta = 0.0,
      vendaliquida = 0.0,
      ticketmedio = 0.0,
      mediadiaria = 0.0,
      margem = 0.0,
      valortotaldevolucao = 0.0,
      valortotalcancelamento = 0.0,
      valortotaldesconto = 0.0,
      valortotal = 0.0,
      valortotalliquido = 0.0,
      valortotalliquidoMes = 0.0,
      vendabrutaMesAnt = 0.0,
      vendaliquidaMesAnt = 0.0,
      ticketmedioMesAnt = 0.0,
      mediadiariaMesAnt = 0.0,
      margemMesAnt = 0.0,
      valortotaldevolucaoMesAnt = 0.0,
      valortotalcancelamentoMesAnt = 0.0,
      valortotaldescontoMesAnt = 0.0,
      valortotalMesAnt = 0.0,
      valortotalliquidoMesAnt = 0.0;

  NumberFormat currencyFormatDefault =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    void _closeModal() {
      //Função para fechar o modal
      Navigator.of(context).pop();
    }

    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Container(
              height: Style.CircularProgressIndicatorWidth(context),
              width: Style.CircularProgressIndicatorWidth(context),
              child: CircularProgressIndicator(
                year2023: false,
                strokeWidth: Style.CircularProgressIndicatorSize(context),
              )),
        ),
      );
    }
    return SafeArea(
      child: PopScope(
        canPop: false, // 🔴 IMPORTANTE
        onPopInvokedWithResult: (didPop, result) async {
          Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SellerMonitorPage(),
                ),
              );
        },
      child: Scaffold(
        drawer: CustomDrawer(),
        body: ListView(
          children: [
            Navbar(text: 'Dados de Vendas', children: [
              DrawerButton(
                style: ButtonStyle(
                    iconSize:
                        WidgetStatePropertyAll(Style.SizeDrawerButton(context)),
                    iconColor: WidgetStatePropertyAll(Style.tertiaryColor),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.all(Style.PaddingDrawerButton(context)))),
              ),
            ]),
            SizedBox(
              height: Style.height_10(context),
            ),
            Container(
                padding: EdgeInsets.only(
                    left: Style.height_20(context),
                    right: Style.height_20(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //     Icon(
                        //   Icons.calendar_month_sharp,
                        //   color: Style.secondaryColor,
                        //   size: Style.height_20(context),
                        // ),
                        // ActionButton(
                        //   text: 'Selecione o Período',
                        //   height: Style.height_15(context)
                        // ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                height: Style.height_30(context),
                                child: PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<String>>[
                                    PopupMenuItem(
                                        enabled: false,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom:
                                                      Style.height_5(context)),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Style.height_5(
                                                              context)),
                                                  color: Style.errorColor),
                                              child: IconButton(
                                                onPressed: () {
                                                  _closeModal();
                                                },
                                                icon: Image.asset(
                                                    'assets/icons/icon_remove.png'),
                                                style: ButtonStyle(
                                                    iconColor:
                                                        WidgetStatePropertyAll(
                                                            Style
                                                                .tertiaryColor)),
                                              ),
                                            ),
                                          ],
                                        )),
                                    PopupMenuDivider(
                                      height: Style.height_1(context),
                                    ),
                                    const PopupMenuItem<String>(
                                      labelTextStyle: WidgetStatePropertyAll(
                                          TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Poppins-Medium',
                                              color: Style.primaryColor)),
                                      value: 'Hoje',
                                      child: Text(
                                        'Hoje',
                                      ),
                                    ),
                                    PopupMenuDivider(
                                      height: Style.height_1(context),
                                    ),
                                    const PopupMenuItem<String>(
                                      labelTextStyle: WidgetStatePropertyAll(
                                          TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Poppins-Medium',
                                              color: Style.primaryColor)),
                                      value: 'Ontem',
                                      child: Text('Ontem'),
                                    ),
                                    PopupMenuDivider(
                                      height: Style.height_1(context),
                                    ),
                                    const PopupMenuItem<String>(
                                      labelTextStyle: WidgetStatePropertyAll(
                                          TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Poppins-Medium',
                                              color: Style.primaryColor)),
                                      value: 'Semana',
                                      child: Text('Semana'),
                                    ),
                                    PopupMenuDivider(
                                      height: Style.height_1(context),
                                    ),
                                    const PopupMenuItem<String>(
                                      labelTextStyle: WidgetStatePropertyAll(
                                          TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Poppins-Medium',
                                              color: Style.primaryColor)),
                                      value: 'Mês',
                                      child: Text('Mês'),
                                    ),
                                  ],
                                  onSelected: (String value) async {
                                    if (value == 'Hoje') {
                                      setState(() {
                                        flagLoadingData = true;
                                        flagToday = 1;
                                        flagMonth = 0;
                                        period = 'm.data%20=%20CURRENT_DATE';
                                      });
                                      fetchDataSales(period);
                                    } else if (value == 'Ontem') {
                                      setState(() {
                                        flagLoadingData = true;
                                        flagYesterday = 1;
                                        flagMonth = 0;
                                        period =
                                            'm.data%20=%20CURRENT_DATE%20-%201';
                                      });
                                      fetchDataSales(period);
                                    } else if (value == 'Semana') {
                                      setState(() {
                                        flagLoadingData = true;
                                        flagWeek = 1;
                                        flagMonth = 0;
                                        period =
                                            'm.data%20=%20ADDDATE(CURDATE(),INTERVAL%20(DAYOFWEEK(CURDATE())-1)*(-1)%20day)';
                                      });
                                      fetchDataSales(period);
                                    } else if (value == 'Mês') {
                                      setState(() {
                                        flagLoadingData = true;
                                        flagMonth = 1;
                                        period =
                                            'm.data%20>=%20ADDDATE(CURDATE(),INTERVAL%20(DAYOFMONTH(CURDATE())-1)*(-1)%20day)';
                                      });
                                      fetchDataSales(period);
                                    }
                                    setState(() {
                                      selectedOptionChild = value;
                                    });
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month_sharp,
                                          color: Style.secondaryColor,
                                          size: Style.height_20(context),
                                        ),
                                        SizedBox(
                                          width: Style.width_10(context),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: Style.height_1(context)),
                                          child: Text(
                                            selectedOptionChild == ''
                                                ? 'Selecione o Período'
                                                : selectedOptionChild,
                                            style: TextStyle(
                                                fontSize:
                                                    Style.height_15(context),
                                                color: Style.secondaryColor),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Inicialmente, os dados são carregados com base na data atual!',
                      style: TextStyle(
                          color: Style.quarantineColor,
                          fontSize: Style.height_10(context)),
                    ),
                  ],
                )),
            SizedBox(
              height: Style.height_10(context),
            ),
            InformativeCard(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCard(
                    text: 'Venda Bruta',
                    fontSize: Style.height_8(context),
                    textAlign: TextAlign.center,
                    color: Style.tertiaryColor,
                    FontWeight: FontWeight.bold,
                  )
                ],
              ),
              verifyLoading(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCard(
                      text: currencyFormatDefault.format(valortotal).toString(),
                      fontSize: Style.height_20(context),
                      textAlign: TextAlign.center,
                      color: Style.tertiaryColor,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Style.height_5(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCard(
                    text: 'Venda Líquida',
                    fontSize: Style.height_8(context),
                    textAlign: TextAlign.center,
                    color: Style.tertiaryColor,
                    FontWeight: FontWeight.bold,
                  )
                ],
              ),
              verifyLoading(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCard(
                      text: currencyFormatDefault
                          .format(valortotalliquido)
                          .toString(),
                      fontSize: Style.height_20(context),
                      textAlign: TextAlign.center,
                      color: Style.tertiaryColor,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Style.height_5(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCard(
                            text: 'Ticket Médio',
                            fontSize: Style.height_8(context),
                            textAlign: TextAlign.center,
                            color: Style.tertiaryColor,
                            FontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                      verifyLoading(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCard(
                              text:
                                  '${currencyFormatDefault.format(ticketmedio)}',
                              fontSize: Style.height_10(context),
                              textAlign: TextAlign.center,
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCard(
                            text: 'Média Diária',
                            fontSize: Style.height_8(context),
                            textAlign: TextAlign.center,
                            color: Style.tertiaryColor,
                            FontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                      verifyLoading(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCard(
                              text: currencyFormatDefault
                                  .format(mediadiaria)
                                  .toString(),
                              fontSize: Style.height_10(context),
                              textAlign: TextAlign.center,
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCard(
                            text: 'Margem',
                            fontSize: Style.height_8(context),
                            textAlign: TextAlign.center,
                            color: Style.tertiaryColor,
                            FontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                      verifyLoading(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCard(
                              text: '${(margem * 100).toStringAsFixed(2)}%',
                              fontSize: Style.height_10(context),
                              textAlign: TextAlign.center,
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Style.height_5(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCard(
                            text: 'Devoluções',
                            fontSize: Style.height_8(context),
                            textAlign: TextAlign.center,
                            color: Style.tertiaryColor,
                            FontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                      verifyLoading(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCard(
                              text: currencyFormatDefault
                                  .format(valortotaldevolucao)
                                  .toString(),
                              fontSize: Style.height_10(context),
                              textAlign: TextAlign.center,
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextCard(
                            text: 'Cancelamentos',
                            fontSize: Style.height_8(context),
                            textAlign: TextAlign.center,
                            color: Style.tertiaryColor,
                            FontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                      verifyLoading(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCard(
                              text: currencyFormatDefault
                                  .format(valortotalcancelamento)
                                  .toString(),
                              fontSize: Style.height_10(context),
                              textAlign: TextAlign.center,
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Style.height_5(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCard(
                    text: 'Descontos aplicados',
                    fontSize: Style.height_8(context),
                    textAlign: TextAlign.center,
                    color: Style.tertiaryColor,
                    FontWeight: FontWeight.bold,
                  )
                ],
              ),
              verifyLoading(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextCard(
                      text: currencyFormatDefault
                          .format(valortotaldesconto)
                          .toString(),
                      fontSize: Style.height_15(context),
                      textAlign: TextAlign.center,
                      color: Style.tertiaryColor,
                    )
                  ],
                ),
              ),
            ], color: Style.primaryColor),
            SizedBox(
              height: Style.height_10(context),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Style.height_20(context),
                right: Style.height_20(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Metas de Vendas Alcançadas',
                    style: TextStyle(
                      color: Style.primaryColor,
                      fontSize: Style.height_8(context),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<Map<String, dynamic>>(
                        future: fetchLayout(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return buildWidgetFromJson(snapshot.data!);
                        },
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     TextCard(
                      //       text: 'Meta Diária',
                      //       fontSize: Style.height_8(context),
                      //       textAlign: TextAlign.center,
                      //       FontWeight: FontWeight.bold,
                      //     )
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     TextCard(
                      //       text: 'R\$ 5.000',
                      //       fontSize: Style.height_15(context),
                      //       textAlign: TextAlign.center,
                      //       FontWeight: FontWeight.bold,
                      //     ),
                      //     Icon(
                      //       Icons.track_changes_rounded,
                      //       color:
                      //           valortotalliquido < 5000 && flagToday == 1
                      //               ? Style.tertiaryColor
                      //               : Style.sucefullColor,
                      //       size: Style.height_15(context),
                      //     )
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     TextCard(
                      //       text: 'Meta Mensal',
                      //       fontSize: Style.height_8(context),
                      //       textAlign: TextAlign.center,
                      //       FontWeight: FontWeight.bold,
                      //     )
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     TextCard(
                      //       text: 'R\$ 150.000',
                      //       fontSize: Style.height_15(context),
                      //       textAlign: TextAlign.center,
                      //       FontWeight: FontWeight.bold,
                      //     ),
                      //     Icon(
                      //       Icons.track_changes_rounded,
                      //       color: (widget.valorMes == null
                      //                   ? valortotalliquidoMes
                      //                   : widget.valorMes ?? 0.0) <
                      //               150000
                      //           ? Style.tertiaryColor
                      //           : Style.sucefullColor,
                      //       size: Style.height_15(context),
                      //     )
                      //   ],
                      // ),
                      if ((widget.valorMes == null
                              ? valortotalliquidoMes
                              : widget.valorMes ?? 0.0) <
                          150000)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextCard(
                              text: 'Faltam no mês',
                              fontSize: Style.height_8(context),
                              textAlign: TextAlign.center,
                              FontWeight: FontWeight.bold,
                              color: Style.errorColor,
                            )
                          ],
                        ),
                      if ((widget.valorMes == null
                              ? valortotalliquidoMes
                              : widget.valorMes ?? 0.0) <
                          150000)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextCard(
                              text:
                                  '${currencyFormatDefault.format(150000 - (widget.valorMes == null ? valortotalliquidoMes : widget.valorMes ?? 0.0))}',
                              fontSize: Style.height_15(context),
                              textAlign: TextAlign.center,
                              FontWeight: FontWeight.bold,
                              color: Style.errorColor,
                            )
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Style.height_15(context),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Style.height_20(context),
                right: Style.height_20(context),
              ),
              alignment: Alignment(0, 0),
              child: CustomButton(
                text: 'Histórico de Vendas',
                fontSize: Style.height_12(context),
                backgroundColor: Style.secondaryColor,
                color: Style.tertiaryColor,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => SaleListPage(
                        pessoa_id: widget.vendedorpessoa_id,
                        period: period,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (flagMonth == 1)
              Container(
                  padding: EdgeInsets.only(
                    top: Style.height_20(context),
                  ),
                  child: Column(
                    children: [
                      Titles(
                          text: 'Mês Anterior', fontSize: Titles.h2(context)),
                      SizedBox(
                        height: Style.height_10(context),
                      ),
                      InformativeCard(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCard(
                              text: 'Venda Bruta',
                              fontSize: Style.height_8(context),
                              textAlign: TextAlign.center,
                              color: Style.tertiaryColor,
                              FontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                        verifyLoading(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextCard(
                                text: currencyFormatDefault
                                    .format(valortotalMesAnt),
                                fontSize: Style.height_20(context),
                                textAlign: TextAlign.center,
                                color: Style.tertiaryColor,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Style.height_5(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCard(
                              text: 'Venda Líquida',
                              fontSize: Style.height_8(context),
                              textAlign: TextAlign.center,
                              color: Style.tertiaryColor,
                              FontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                        verifyLoading(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextCard(
                                text: currencyFormatDefault
                                    .format(valortotalliquidoMesAnt),
                                fontSize: Style.height_20(context),
                                textAlign: TextAlign.center,
                                color: Style.tertiaryColor,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Style.height_5(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextCard(
                                      text: 'Ticket Médio',
                                      fontSize: Style.height_8(context),
                                      textAlign: TextAlign.center,
                                      color: Style.tertiaryColor,
                                      FontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                                verifyLoading(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextCard(
                                        text:
                                            '${currencyFormatDefault.format(ticketmedioMesAnt)}',
                                        fontSize: Style.height_10(context),
                                        textAlign: TextAlign.center,
                                        color: Style.tertiaryColor,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextCard(
                                      text: 'Média Diária',
                                      fontSize: Style.height_8(context),
                                      textAlign: TextAlign.center,
                                      color: Style.tertiaryColor,
                                      FontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                                verifyLoading(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextCard(
                                        text: currencyFormatDefault
                                            .format(mediadiariaMesAnt)
                                            .toString(),
                                        fontSize: Style.height_10(context),
                                        textAlign: TextAlign.center,
                                        color: Style.tertiaryColor,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextCard(
                                      text: 'Margem',
                                      fontSize: Style.height_8(context),
                                      textAlign: TextAlign.center,
                                      color: Style.tertiaryColor,
                                      FontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                                verifyLoading(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextCard(
                                        text:
                                            '${(margemMesAnt * 100).toStringAsFixed(2)}%',
                                        fontSize: Style.height_10(context),
                                        textAlign: TextAlign.center,
                                        color: Style.tertiaryColor,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Style.height_5(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextCard(
                                      text: 'Devoluções',
                                      fontSize: Style.height_8(context),
                                      textAlign: TextAlign.center,
                                      color: Style.tertiaryColor,
                                      FontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                                verifyLoading(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextCard(
                                        text: currencyFormatDefault
                                            .format(valortotaldevolucaoMesAnt),
                                        fontSize: Style.height_10(context),
                                        textAlign: TextAlign.center,
                                        color: Style.tertiaryColor,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextCard(
                                      text: 'Cancelamentos',
                                      fontSize: Style.height_8(context),
                                      textAlign: TextAlign.center,
                                      color: Style.tertiaryColor,
                                      FontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                                verifyLoading(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextCard(
                                        text: currencyFormatDefault.format(
                                            valortotalcancelamentoMesAnt),
                                        fontSize: Style.height_10(context),
                                        textAlign: TextAlign.center,
                                        color: Style.tertiaryColor,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Style.height_5(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCard(
                              text: 'Descontos aplicados',
                              fontSize: Style.height_8(context),
                              textAlign: TextAlign.center,
                              color: Style.tertiaryColor,
                              FontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                        verifyLoading(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextCard(
                                text: currencyFormatDefault
                                    .format(valortotaldescontoMesAnt),
                                fontSize: Style.height_15(context),
                                textAlign: TextAlign.center,
                                color: Style.tertiaryColor,
                              )
                            ],
                          ),
                        )
                      ], color: Style.primaryColor),
                      SizedBox(
                        height: Style.height_10(context),
                      ),
                      // Container(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         'Total de vendas',
                      //         style: TextStyle(
                      //           color: Style.primaryColor,
                      //           fontSize: Style.height_8(context),
                      //         ),
                      //       ),
                      //       Titles(
                      //         text: currencyFormatDefault
                      //             .format(widget.valortotal)
                      //             .toString(),
                      //         fontSize: Titles.h2(context),
                      //         FontWeight: FontWeight.bold,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: Style.height_10(context),
                      // ),
                      Container(
                        padding: EdgeInsets.only(
                          left: Style.height_20(context),
                          right: Style.height_20(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Metas de Vendas Alcançadas',
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: Style.height_8(context),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextCard(
                                      text: 'Meta Mensal',
                                      fontSize: Style.height_8(context),
                                      textAlign: TextAlign.center,
                                      FontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextCard(
                                      text: 'R\$ 150.000',
                                      fontSize: Style.height_15(context),
                                      textAlign: TextAlign.center,
                                      FontWeight: FontWeight.bold,
                                    ),
                                    Icon(
                                      Icons.money_off_csred,
                                      color:
                                          (widget.valorMesAnt ?? 0.0) >= 150000
                                              ? Style.tertiaryColor
                                              : Style.errorColor,
                                      size: Style.height_15(context),
                                    )
                                  ],
                                ),
                                if ((widget.valorMesAnt ?? 0.0) < 150000)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextCard(
                                        text: 'Faltaram no mês',
                                        fontSize: Style.height_8(context),
                                        textAlign: TextAlign.center,
                                        FontWeight: FontWeight.bold,
                                        color: Style.errorColor,
                                      )
                                    ],
                                  ),
                                if ((widget.valorMesAnt ?? 0.0) < 150000)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextCard(
                                        text:
                                            '${currencyFormatDefault.format(150000 - (widget.valorMesAnt ?? 0.0))}',
                                        fontSize: Style.height_15(context),
                                        textAlign: TextAlign.center,
                                        FontWeight: FontWeight.bold,
                                        color: Style.errorColor,
                                      )
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Style.height_15(context),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: Style.height_20(context),
                          right: Style.height_20(context),
                        ),
                        alignment: Alignment(0, 0),
                        child: CustomButton(
                          text: 'Histórico de Vendas',
                          fontSize: Style.height_12(context),
                          backgroundColor: Style.secondaryColor,
                          color: Style.tertiaryColor,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => SaleListPage(
                                  pessoa_id: widget.vendedorpessoa_id,
                                  period:
                                      '''m.data%20%3E=%20DATE_FORMAT(CURDATE()%20-%20INTERVAL%201%20MONTH,%20'%Y-%m-01')%20AND%20m.data%20%3C=%20LAST_DAY(CURDATE()%20-%20INTERVAL%201%20MONTH)%20AND%20m.flagcancelado%20%3C%3E%201''',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: Style.height_20(context),
                      )
                    ],
                  ))
            else
              SizedBox(
                height: Style.height_10(context),
              )
          ],
        ),
      ),
    ));
  }

  ValueNotifier<double>? get monthValueNotifier =>
      sellerPageKey.currentState?.monthValueNotifier;

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
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

  Future<void> loadData() async {
    await Future.wait([_loadSavedUrlBasic(), _loadSavedSellerId()]);
    await Future.wait([fetchDataSales(period), monthValue(), fetchLayout()]);
    print(valortotalliquidoMes);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchDataSales(String period) async {
    final fetchData = await SalesResultValues.fetchDataSales(
        urlBasic, widget.vendedorpessoa_id, period, flagFilter, '');
    if (fetchData != null) {
      setState(() {
        valortotal = fetchData.totalValueGross;
        valortotalliquido = fetchData.totalValueLiquid;
        valortotaldesconto = fetchData.discounts;
        valortotaldevolucao = fetchData.returns;
        valortotalcancelamento = fetchData.cancellations;
        ticketmedio = fetchData.averageTicket;
        mediadiaria = fetchData.dailyAverage;
        margem = fetchData.margin;
        if (flagMonth != 1) {
          flagLoadingData = false;
        }
      });
      if (flagMonth == 1) {
        setState(() {
          valortotalliquidoMes = fetchData.totalValueLiquid;
        });
        final fetchDataPrevMonth = await SalesResultValues.fetchDataSales(
            urlBasic,
            widget.vendedorpessoa_id,
            '''m.data%20%3E=%20DATE_FORMAT(CURDATE()%20-%20INTERVAL%201%20MONTH,%20'%Y-%m-01')%20AND%20m.data%20%3C=%20LAST_DAY(CURDATE()%20-%20INTERVAL%201%20MONTH)''',
            flagFilter,
            '');
        if (fetchDataPrevMonth != null) {
          setState(() {
            valortotalMesAnt = fetchDataPrevMonth.totalValueGross;
            valortotalliquidoMesAnt = fetchDataPrevMonth.totalValueLiquid;
            valortotaldescontoMesAnt = fetchDataPrevMonth.discounts;
            valortotaldevolucaoMesAnt = fetchDataPrevMonth.returns;
            valortotalcancelamentoMesAnt = fetchDataPrevMonth.cancellations;
            ticketmedioMesAnt = fetchDataPrevMonth.averageTicket;
            mediadiariaMesAnt = fetchDataPrevMonth.dailyAverage;
            margemMesAnt = fetchDataPrevMonth.margin;
            flagLoadingData = false;
          });
        }
      }
    }
  }

  Future<double> monthValue() async {
    try {
      var urlReq = Uri.parse(
          '''$urlBasic/ideia/core/getdata/movimentosaida%20m%20LEFT%20JOIN%20movimentoentrada%20me%20ON%20me.ref_movimentosaida_id%20=%20m.movimentosaida_id%20WHERE%20m.vendedor_pessoa_id%20=%20'$vendedorId'%20AND%20m.data%20>=%20ADDDATE(CURDATE(),INTERVAL%20(DAYOFMONTH(CURDATE())-1)*(-1)%20day)/''');
      var headers = {"Accept": "text/html"};
      var responseReq = await http.get(urlReq, headers: headers);
      print(urlReq);
      if (responseReq.statusCode == 200) {
        var data = jsonDecode(responseReq.body);
        var key = data['data'].keys.first;
        var list = data['data'][key];
        if (list != null && list.isNotEmpty) {
          var totalValueGross =
              list.fold(0.0, (sum, item) => sum + (item['valortotal'] ?? 0.0));
          var discounts = list.fold(
              0.0, (sum, item) => sum + (item['valortotaldesconto'] ?? 0.0));
          var returns = list.fold(
              0.0,
              (sum, item) =>
                  sum +
                  (item['flagdevolucaovenda'] == 1
                      ? (item['valortotal'] ?? 0.0)
                      : 0.0));
          var cancellations = list.fold(
              0.0,
              (sum, item) =>
                  sum +
                  (item['flagcancelado'] == 1
                      ? (item['valortotal'] ?? 0.0)
                      : 0.0));
          var subtration = discounts + cancellations + returns;
          print(returns);
          print(cancellations);
          valortotalliquidoMes =
              list.fold(0.0, (sum, item) => totalValueGross - subtration);
          print(valortotalliquidoMes);
        } else {
          print('Lista vazia');
        }
      } else {
        print(responseReq.body);
      }
    } catch (e) {
      print(e);
    }
    return valortotalliquidoMes;
  }

  // Future<void> fetchDataSales() async {
  //   final fetchData =
  //       await SalesResultValues.fetchDataSales(urlBasic, widget.vendedorId);
  //   if (fetchData != null) {
  //     setState(() {
  //       sales = fetchData.sales;
  //       todayValue = fetchData.totalToday ?? 0.0;
  //       yesterdayValue = fetchData.totalYesterday ?? 0.0;
  //       weekValue = fetchData.totalWeek ?? 0.0;
  //       monthValue = fetchData.totalMonth ?? 0.0;
  //       prevMonthValue = fetchData.totalPrevMonth ?? 0.0;
  //     });
  //   } else {
  //     print("Bigode - $fetchData");
  //   }
  // }
  Widget verifyLoading({required Widget child}) {
    if (flagLoadingData) {
      return SizedBox(
        width: Style.height_70(context),
        child: CardLoading(
          cardLoadingTheme: CardLoadingTheme(
            colorOne: const Color.fromARGB(255, 3, 99, 163),
            colorTwo: const Color.fromARGB(255, 1, 61, 100),
          ),
          height: Style.height_15(context),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      );
    }
    return child;
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

  static Future<Map<String, dynamic>> fetchLayout() async {
    final response = await http.get(
      Uri.parse(
        'http://licenciamento.ideiatecnologia.com.br:8997/ideia/public/ideiaseller/goals_sale_monitor.json',
      ),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      print('Erro HTTP: ${response.statusCode}');
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
}
