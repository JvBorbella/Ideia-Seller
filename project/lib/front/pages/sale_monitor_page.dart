import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/back/sales_monitor_functions/sale_monitor_data.dart';
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

class SaleMonitor extends StatefulWidget {
  final vendedorpessoa_id;
  const SaleMonitor({Key? key, this.vendedorpessoa_id});

  @override
  State<SaleMonitor> createState() => _SaleMonitorState();
}

class _SaleMonitorState extends State<SaleMonitor> {
  String urlBasic = '';
  String selectedOptionChild = '';
  int flagToday = 0;
  int flagYesterday = 0;
  int flagWeek = 0;
  int flagMonth = 0;
  bool isLoading = true;

  String vendedorpessoa_id = '';
  double vendabruta = 0.0;
  double vendaliquida = 0.0;
  double ticketmedio = 0.0;
  double mediadiaria = 0.0;
  double margem = 0.0;
  double valortotaldevolucao = 0.0;
  double valortotalcancelamento = 0.0;
  double valortotaldesconto = 0.0;
  double valortotal = 0.0;

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
        child: WillPopScope(
            child: Scaffold(
              drawer: CustomDrawer(),
              body: ListView(
                children: [
                  Navbar(text: 'Dados de Vendas', children: [
                    DrawerButton(
                      style: ButtonStyle(
                          iconSize: WidgetStatePropertyAll(
                              Style.SizeDrawerButton(context)),
                          iconColor:
                              WidgetStatePropertyAll(Style.tertiaryColor),
                          padding: WidgetStatePropertyAll(EdgeInsets.all(
                              Style.PaddingDrawerButton(context)))),
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
                                                        bottom: Style.height_5(
                                                            context)),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Style.height_5(
                                                                    context)),
                                                        color:
                                                            Style.errorColor),
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
                                            labelTextStyle:
                                                WidgetStatePropertyAll(
                                                    TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'Poppins-Medium',
                                                        color: Style
                                                            .primaryColor)),
                                            value: 'Hoje',
                                            child: Text(
                                              'Hoje',
                                            ),
                                          ),
                                          PopupMenuDivider(
                                            height: Style.height_1(context),
                                          ),
                                          const PopupMenuItem<String>(
                                            labelTextStyle:
                                                WidgetStatePropertyAll(
                                                    TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'Poppins-Medium',
                                                        color: Style
                                                            .primaryColor)),
                                            value: 'Ontem',
                                            child: Text('Ontem'),
                                          ),
                                          PopupMenuDivider(
                                            height: Style.height_1(context),
                                          ),
                                          const PopupMenuItem<String>(
                                            labelTextStyle:
                                                WidgetStatePropertyAll(
                                                    TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'Poppins-Medium',
                                                        color: Style
                                                            .primaryColor)),
                                            value: 'Semana',
                                            child: Text('Semana'),
                                          ),
                                          PopupMenuDivider(
                                            height: Style.height_1(context),
                                          ),
                                          const PopupMenuItem<String>(
                                            labelTextStyle:
                                                WidgetStatePropertyAll(
                                                    TextStyle(
                                                        fontSize: 20,
                                                        fontFamily:
                                                            'Poppins-Medium',
                                                        color: Style
                                                            .primaryColor)),
                                            value: 'Mês',
                                            child: Text('Mês'),
                                          ),
                                          PopupMenuDivider(
                                            height: Style.height_1(context),
                                          ),
                                        ],
                                        onSelected: (String value) async {
                                          if (value == 'Hoje') {
                                            setState(() {
                                              flagToday = 1;
                                            });
                                          } else if (value == 'Ontem') {
                                            setState(() {
                                              flagYesterday = 1;
                                            });
                                          } else if (value == 'Semana') {
                                            setState(() {
                                              flagWeek = 1;
                                            });
                                          } else if (value == 'Mês') {
                                            setState(() {
                                              flagMonth = 1;
                                            });
                                          }
                                          setState(() {
                                            selectedOptionChild = value;
                                          });
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.calendar_month_sharp,
                                                color: Style.secondaryColor,
                                                size: Style.height_20(context),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: Style.height_1(
                                                        context)),
                                                child: Text(
                                                  selectedOptionChild == ''
                                                      ? 'Selecione o Período'
                                                      : selectedOptionChild,
                                                  style: TextStyle(
                                                      fontSize: Style.height_15(
                                                          context),
                                                      color:
                                                          Style.secondaryColor),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextCard(
                          text: currencyFormatDefault
                              .format(vendabruta)
                              .toString(),
                          fontSize: Style.height_20(context),
                          textAlign: TextAlign.center,
                          color: Style.tertiaryColor,
                        )
                      ],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextCard(
                          text: currencyFormatDefault
                              .format(vendaliquida)
                              .toString(),
                          fontSize: Style.height_20(context),
                          textAlign: TextAlign.center,
                          color: Style.tertiaryColor,
                        )
                      ],
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextCard(
                                  text: ticketmedio.toString(),
                                  fontSize: Style.height_10(context),
                                  textAlign: TextAlign.center,
                                  color: Style.tertiaryColor,
                                )
                              ],
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
                            Row(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextCard(
                                  text: margem.toString(),
                                  fontSize: Style.height_10(context),
                                  textAlign: TextAlign.center,
                                  color: Style.tertiaryColor,
                                )
                              ],
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
                            Row(
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
                            Row(
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
                    Row(
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
                  ], color: Style.primaryColor),
                  SizedBox(
                    height: Style.height_10(context),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total de vendas',
                          style: TextStyle(
                            color: Style.primaryColor,
                            fontSize: Style.height_8(context),
                          ),
                        ),
                        Titles(
                          text: currencyFormatDefault
                              .format(valortotal)
                              .toString(),
                          fontSize: Titles.h2(context),
                          FontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextCard(
                                  text: 'Meta Diária',
                                  fontSize: Style.height_8(context),
                                  textAlign: TextAlign.center,
                                  FontWeight: FontWeight.bold,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextCard(
                                  text: 'RS 5.000',
                                  fontSize: Style.height_15(context),
                                  textAlign: TextAlign.center,
                                  FontWeight: FontWeight.bold,
                                ),
                                Icon(
                                  Icons.track_changes_rounded,
                                  color: Style.sucefullColor,
                                  size: Style.height_15(context),
                                )
                              ],
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextCard(
                                  text: 'RS 80.000',
                                  fontSize: Style.height_15(context),
                                  textAlign: TextAlign.center,
                                  FontWeight: FontWeight.bold,
                                )
                              ],
                            ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextCard(
                                  text: 'RS -90.000',
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
                            builder: (context) => SaleListPage(pessoa_id: widget.vendedorpessoa_id,),
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
                                text: 'Mês Anterior',
                                fontSize: Titles.h2(context)),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextCard(
                                    text: 'RS 000.000,00',
                                    fontSize: Style.height_20(context),
                                    textAlign: TextAlign.center,
                                    color: Style.tertiaryColor,
                                  )
                                ],
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextCard(
                                    text: 'RS 000.000,00',
                                    fontSize: Style.height_20(context),
                                    textAlign: TextAlign.center,
                                    color: Style.tertiaryColor,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Style.height_5(context),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextCard(
                                            text: 'RS 000,00',
                                            fontSize: Style.height_10(context),
                                            textAlign: TextAlign.center,
                                            color: Style.tertiaryColor,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextCard(
                                            text: 'RS 000,00',
                                            fontSize: Style.height_10(context),
                                            textAlign: TextAlign.center,
                                            color: Style.tertiaryColor,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextCard(
                                            text: '0.00%',
                                            fontSize: Style.height_10(context),
                                            textAlign: TextAlign.center,
                                            color: Style.tertiaryColor,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Style.height_5(context),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextCard(
                                            text: 'RS 000,00',
                                            fontSize: Style.height_10(context),
                                            textAlign: TextAlign.center,
                                            color: Style.tertiaryColor,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextCard(
                                            text: 'RS 000,00',
                                            fontSize: Style.height_10(context),
                                            textAlign: TextAlign.center,
                                            color: Style.tertiaryColor,
                                          )
                                        ],
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextCard(
                                    text: 'RS 000.000,00',
                                    fontSize: Style.height_15(context),
                                    textAlign: TextAlign.center,
                                    color: Style.tertiaryColor,
                                  )
                                ],
                              ),
                            ], color: Style.primaryColor),
                            SizedBox(
                              height: Style.height_10(context),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total de vendas',
                                    style: TextStyle(
                                      color: Style.primaryColor,
                                      fontSize: Style.height_8(context),
                                    ),
                                  ),
                                  Titles(
                                    text: 'RS 000.000,00',
                                    fontSize: Titles.h2(context),
                                    FontWeight: FontWeight.bold,
                                  )
                                ],
                              ),
                            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextCard(
                                            text: 'Meta Diária',
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
                                            text: 'RS 5.000',
                                            fontSize: Style.height_15(context),
                                            textAlign: TextAlign.center,
                                            FontWeight: FontWeight.bold,
                                          ),
                                          Icon(
                                            Icons.track_changes_rounded,
                                            color: Style.sucefullColor,
                                            size: Style.height_15(context),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            MainAxisAlignment.start,
                                        children: [
                                          TextCard(
                                            text: 'RS 80.000',
                                            fontSize: Style.height_15(context),
                                            textAlign: TextAlign.center,
                                            FontWeight: FontWeight.bold,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextCard(
                                            text: 'RS -90.000',
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
                                      builder: (context) => SaleListPage(pessoa_id: widget.vendedorpessoa_id,),
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
            onWillPop: () async {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SellerMonitorPage(),
                ),
              );
              return true;
            }));
  }

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
  }

  Future<void> fetchDataSaleMonitor() async {
    Map<String?, dynamic> fetchedData =
        await DataServiceSaleMonitor.fetchDataSaleMonitor(
            widget.vendedorpessoa_id, urlBasic);
    print(widget.vendedorpessoa_id);
    setState(() {
      vendedorpessoa_id = fetchedData['vendedorpessoa_id'] ?? '';
      vendabruta = fetchedData['vendabruta'] ?? 0.0;
      vendaliquida = fetchedData['vendaliquida'] ?? 0.0;
      ticketmedio = fetchedData['ticketmedio'] ?? 0.0;
      mediadiaria = fetchedData['mediadiaria'] ?? 0.0;
      margem = fetchedData['margem'] ?? 0.0;
      valortotaldevolucao = fetchedData['valortotaldevolucao'] ?? 0.0;
      valortotalcancelamento = fetchedData['valortotalcancelamento'] ?? 0.0;
      valortotaldesconto = fetchedData['valortotaldesconto'] ?? 0.0;
      valortotal = fetchedData['valortotal'] ?? 0.0;
    });
  }

  Future<void> loadData() async {
    await Future.wait([_loadSavedUrlBasic()]);
    await Future.wait([fetchDataSaleMonitor()]);
    setState(() {
      isLoading = false;
    });
  }
}
