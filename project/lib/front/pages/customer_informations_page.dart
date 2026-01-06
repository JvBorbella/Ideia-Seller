import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/back/customer_base/customer_detail.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/structure/informative_card.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/components/texts/titles.dart';
import 'package:project/front/pages/customer_portifolio_page.dart';
import 'package:project/front/pages/sale_details_page.dart';
import 'package:project/front/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerInformations extends StatefulWidget {
  final customerId;
  const CustomerInformations({super.key, required this.customerId});

  @override
  State<CustomerInformations> createState() => _CustomerInformationsState();
}

class _CustomerInformationsState extends State<CustomerInformations> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  NumberFormat currencyFormatDefault =
      NumberFormat.currency(locale: 'pt_BR', symbol: '');

  String codigo = '', nome = '';
  dynamic data_ultima_venda,
      data_ultimo_pagamento,
      valor_total_vendas,
      valor_total_devolucoes,
      valor_total_credito,
      qtde_vencido,
      valor_vencido,
      valor_a_vencer,
      valor_devedor,
      limitecredito;

  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => CustomerPortifolioPage(),
                ),
              );
        },
      child: Scaffold(
              drawer: CustomDrawer(),
              body: ListView(
                children: [
                  Navbar(text: 'Informações do cliente', children: [
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
                      right: Style.height_20(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Titles(
                            text: '${codigo} - ${nome}',
                            fontSize: Titles.h3(context)),
                        SizedBox(
                          height: Style.height_10(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                TextCard(
                                  text: 'Venda',
                                  fontSize: Style.height_8(context),
                                  color: Style.quarantineColor,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: currencyFormatDefault.format(valor_total_vendas ?? 0.0),
                                  fontSize: Style.height_10(context),
                                  color: Style.primaryColor,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextCard(
                                  text: 'Devolução',
                                  fontSize: Style.height_8(context),
                                  color: Style.quarantineColor,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: currencyFormatDefault.format(valor_total_devolucoes ?? 0.0),
                                  fontSize: Style.height_10(context),
                                  color: Style.primaryColor,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextCard(
                                  text: 'Crédito / Limite',
                                  fontSize: Style.height_8(context),
                                  color: Style.quarantineColor,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: currencyFormatDefault.format(valor_total_credito ?? 0.0),
                                  fontSize: Style.height_10(context),
                                  color: Style.primaryColor,
                                ),
                                TextCard(
                                  text: currencyFormatDefault.format(limitecredito ?? 0.0),
                                  fontSize: Style.height_10(context),
                                  FontWeight: FontWeight.bold,
                                  color: Style.warningColor,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Style.height_10(context),
                  ),
                  SizedBox(
                    height: Style.height_20(context),
                  ),
                  Titles(
                    text: 'Financeiro',
                    fontSize: Titles.h4(context),
                    FontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: Style.height_10(context),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: Style.height_20(context),
                      right: Style.height_20(context),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(Style.height_2(context)),
                      decoration: BoxDecoration(
                          color: Style.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Style.height_10(context)),
                            topRight: Radius.circular(Style.height_10(context)),
                          )),
                      child: Text(
                        'Títulos',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Style.tertiaryColor,
                          fontSize: Style.height_12(context),
                        ),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: Style.height_20(context),
                      right: Style.height_20(context),
                    ),
                    alignment: Alignment.center,
                    child: Table(
                      border: TableBorder.all(
                          width: 1,
                          color: Style.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft:
                                Radius.circular(Style.height_10(context)),
                            bottomRight:
                                Radius.circular(Style.height_10(context)),
                          )),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Style.primaryColor,
                          ),
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                'Qtde. Venc.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Style.tertiaryColor,
                                  fontSize: Style.height_8(context),
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                'A Vencer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Style.tertiaryColor,
                                  fontSize: Style.height_8(context),
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                'Vencido',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Style.tertiaryColor,
                                  fontSize: Style.height_8(context),
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                'Devendo',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Style.tertiaryColor,
                                  fontSize: Style.height_8(context),
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                qtde_vencido.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Style.height_8(context)),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                currencyFormatDefault.format(valor_a_vencer ?? 0.0),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Style.height_8(context)),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                currencyFormatDefault.format(valor_vencido ?? 0.0),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Style.height_8(context)),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                currencyFormatDefault.format(valor_devedor ?? 0.0),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Style.height_8(context)),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Style.height_25(context),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: Style.height_20(context),
                      right: Style.height_20(context),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(Style.height_2(context)),
                      decoration: BoxDecoration(
                          color: Style.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Style.height_10(context)),
                            topRight: Radius.circular(Style.height_10(context)),
                          )),
                      child: Text(
                        'Saldo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Style.tertiaryColor,
                          fontSize: Style.height_12(context),
                        ),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: Style.height_20(context),
                      right: Style.height_20(context),
                    ),
                    alignment: Alignment.center,
                    child: Table(
                      border: TableBorder.all(
                          width: 1,
                          color: Style.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft:
                                Radius.circular(Style.height_10(context)),
                            bottomRight:
                                Radius.circular(Style.height_10(context)),
                          )),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Style.primaryColor,
                          ),
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                'Ult. Pgto.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Style.tertiaryColor,
                                  fontSize: Style.height_8(context),
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                'Ult. Venda',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Style.tertiaryColor,
                                  fontSize: Style.height_8(context),
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                '+30D',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Style.tertiaryColor,
                                  fontSize: Style.height_8(context),
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                data_ultimo_pagamento == null ? 'Sem pagamento' :
                                DateFormat('dd/MM/yyyy').format(data_ultimo_pagamento).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Style.height_8(context)),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                data_ultima_venda == null ? 'Sem vendas' :
                                DateFormat('dd/MM/yyyy').format(data_ultima_venda).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Style.height_8(context)),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                  top: Style.height_10(context),
                                  bottom: Style.height_10(context),
                                ),
                                child: Icon(
                                  Icons.error,
                                  color: data_ultima_venda != null && DateTime.now().difference(data_ultima_venda).inDays >= 30 ? Style.errorColor : Style.tertiaryColor,
                                  size: Style.height_15(context),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           ));
  }

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
  }

  Future<void> loadData() async {
    await Future.wait([_loadSavedUrlBasic()]);
    await Future.wait([fetchDataCustomerDetail()]);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchDataCustomerDetail() async {
    final fetchData = await DataServiceCustomerDetail.fetchDataCustomerDetail(
        urlBasic, widget.customerId);
    if (fetchData != null) {
      setState(() {
        codigo = fetchData.codigo;
        nome = fetchData.nome;
        data_ultima_venda = fetchData.data_ultima_venda;
        data_ultimo_pagamento = fetchData.data_ultimo_pagamento;
        valor_total_vendas = fetchData.valor_total_vendas;
        valor_total_devolucoes = fetchData.valor_total_devolucoes;
        valor_total_credito = fetchData.valor_total_credito;
        qtde_vencido = fetchData.qtde_vencido;
        valor_vencido = fetchData.valor_vencido;
        valor_a_vencer = fetchData.valor_a_vencer;
        valor_devedor = fetchData.valor_devedor;
        limitecredito = fetchData.limitecredito;
      });
    }
  }
}
