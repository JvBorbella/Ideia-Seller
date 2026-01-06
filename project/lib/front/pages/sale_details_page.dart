import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/back/sales_monitor_functions/sale_details_data.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/structure/informative_card.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/components/texts/titles.dart';
import 'package:project/front/pages/sale_list_page.dart';
import 'package:project/front/pages/sale_monitor_page.dart';
import 'package:project/front/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaleDetails extends StatefulWidget {
  final movimentosaidaId;
  const SaleDetails({super.key, this.movimentosaidaId});

  @override
  State<SaleDetails> createState() => _SaleDetailsState();
}

bool isLoading = true;
String urlBasic = '',
    vendedorId = '',
    codigopessoa = '',
    nomepessoa = '',
    empresaCodigo = '',
    empresaNome = '',
    numeroPedido = '',
    numeromovimento = '',
    terminal = '',
    pessoa_id = '';
double valortotalmovimento = 0.0,
    valorsubtotal = 0.0,
    outrasdespesas = 0.0,
    valordesconto = 0.0,
    valorfrete = 0.0,
    margem = 0.0;
List<SaleDetailsData> saleDetails = [], salesPayments = [];

NumberFormat currencyFormatDefault =
    NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

class _SaleDetailsState extends State<SaleDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  builder: (context) => SaleListPage(),
                ),
              );
        },
      child: Scaffold(
              drawer: CustomDrawer(),
              body: ListView(
                children: [
                  Navbar(text: 'Detalhes da Venda', children: [
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Cliente: ', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Style.primaryColor,
                              fontSize: Titles.h3(context)
                            ),
                            textAlign: TextAlign.start,),
                            Container(
                              width: Style.width_320(context),
                              child: Titles(
                            text: '${codigopessoa} - ${nomepessoa}',
                            textAlign: TextAlign.start,
                            fontSize: Titles.h3(context)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Empresa: ', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Style.primaryColor,
                              fontSize: Style.height_10(context)
                            ),
                            textAlign: TextAlign.start,),
                            Container(
                              width: Style.width_320(context),
                              child: Titles(
                            text: '${empresaCodigo} - ${empresaNome}',
                            textAlign: TextAlign.start,
                            fontSize: Style.height_10(context)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Nº Pedido: ', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Style.primaryColor,
                              fontSize: Style.height_10(context)
                            ),
                            textAlign: TextAlign.start,),
                            Container(
                              width: Style.width_320(context),
                              child: Titles(
                            text: '${numeroPedido}',
                            textAlign: TextAlign.start,
                            fontSize: Style.height_10(context)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Nº Movimento: ', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Style.primaryColor,
                              fontSize: Style.height_10(context)
                            ),
                            textAlign: TextAlign.start,),
                            Container(
                              width: Style.width_320(context),
                              child: Titles(
                            text: '${numeromovimento}',
                            textAlign: TextAlign.start,
                            fontSize: Style.height_10(context)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Terminal: ', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Style.primaryColor,
                              fontSize: Style.height_10(context)
                            ),
                            textAlign: TextAlign.start,),
                            Container(
                              width: Style.width_320(context),
                              child: Titles(
                            text: '${terminal}',
                            textAlign: TextAlign.start,
                            fontSize: Style.height_10(context)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Style.height_10(context),
                  ),
                  InformativeCard(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            TextCard(
                              text: 'Valor Total da Venda',
                              fontSize: Style.height_8(context),
                              color: Style.tertiaryColor,
                              FontWeight: FontWeight.bold,
                            ),
                            TextCard(
                              text:
                                  '${currencyFormatDefault.format(valortotalmovimento)}',
                              fontSize: Style.height_25(context),
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextCard(
                              text: 'Subtotal',
                              fontSize: Style.height_7(context),
                              color: Style.tertiaryColor,
                              FontWeight: FontWeight.bold,
                            ),
                            TextCard(
                              text:
                                  '${currencyFormatDefault.format(valorsubtotal)}',
                              fontSize: Style.height_8(context),
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            TextCard(
                              text: 'Out. Desp.',
                              fontSize: Style.height_7(context),
                              color: Style.tertiaryColor,
                              FontWeight: FontWeight.bold,
                            ),
                            TextCard(
                              text:
                                  '${currencyFormatDefault.format(outrasdespesas)}',
                              fontSize: Style.height_8(context),
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            TextCard(
                              text: 'Desc. Total',
                              fontSize: Style.height_7(context),
                              color: Style.tertiaryColor,
                              FontWeight: FontWeight.bold,
                            ),
                            TextCard(
                              text:
                                  '${currencyFormatDefault.format(valordesconto)}',
                              fontSize: Style.height_8(context),
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            TextCard(
                              text: 'Frete',
                              fontSize: Style.height_7(context),
                              color: Style.tertiaryColor,
                              FontWeight: FontWeight.bold,
                            ),
                            TextCard(
                              text:
                                  '${currencyFormatDefault.format(valorfrete)}',
                              fontSize: Style.height_8(context),
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            TextCard(
                              text: 'Margem',
                              fontSize: Style.height_7(context),
                              color: Style.tertiaryColor,
                              FontWeight: FontWeight.bold,
                            ),
                            TextCard(
                              text: '${margem}%',
                              fontSize: Style.height_8(context),
                              color: Style.tertiaryColor,
                            )
                          ],
                        ),
                      ],
                    )
                  ], color: Style.primaryColor),
                  SizedBox(
                    height: Style.height_20(context),
                  ),
                  Titles(
                    text: 'Pagamentos',
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
                    alignment: Alignment.center,
                    child: Table(
                      border: TableBorder.all(
                        width: 1,
                        color: Style.primaryColor,
                        borderRadius:
                            BorderRadius.circular(Style.height_10(context)),
                      ),
                      children: [
                        // HEADER
                        TableRow(
                          decoration: BoxDecoration(
                            color: Style.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(Style.height_10(context)),
                              topRight:
                                  Radius.circular(Style.height_10(context)),
                            ),
                          ),
                          children: [
                            _headerCell('Cond. Pgto.'),
                            _headerCell('Valor'),
                          ],
                        ),

                        // LINHAS DINÂMICAS
                        ...salesPayments.map((item) {
                          return TableRow(
                            children: [
                              _cell(item.nomecondicaopagamento.toString()),
                              _cell(currencyFormatDefault
                                  .format(item.valorpagamento)
                                  .toString()),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Style.height_20(context),
                  ),
                  Titles(
                    text: 'Produtos',
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
                    alignment: Alignment.center,
                    child: Table(
                      border: TableBorder.all(
                        width: 1,
                        color: Style.primaryColor,
                        borderRadius:
                            BorderRadius.circular(Style.height_10(context)),
                      ),
                      children: [
                        // HEADER
                        TableRow(
                          decoration: BoxDecoration(
                            color: Style.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(Style.height_10(context)),
                              topRight:
                                  Radius.circular(Style.height_10(context)),
                            ),
                          ),
                          children: [
                            _headerCell('Cód.'),
                            _headerCell('Nome'),
                            _headerCell('Qtde.'),
                            _headerCell('Exp.'),
                            _headerCell('Desc.'),
                            _headerCell('Valor'),
                          ],
                        ),

                        // LINHAS DINÂMICAS
                        ...saleDetails.map((item) {
                          return TableRow(
                            children: [
                              _cell(item.codigoproduto.toString()),
                              _cell(item.nomeproduto.toString()),
                              _cell(item.quantidadeproduto.toString()),
                              _cell(item.expedicao.toString()),
                              _cell(currencyFormatDefault
                                  .format(item.valordescontoitem)
                                  .toString()),
                              _cell(currencyFormatDefault
                                  .format(item.valortotalitem)
                                  .toString()),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           ));
  }

  Future<void> _loadSavedSellerId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedVendedorId =
        await sharedPreferences.getString('vendedor_id') ?? '';
    setState(() {
      pessoa_id = savedVendedorId;
    });
  }

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
  }

  Future<void> fetchDataSaleDetails() async {
    final fetchData = await DataServiceSaleDetails.fetchDataSaleDetails(
        urlBasic, widget.movimentosaidaId);
    if (fetchData != null) {
      setState(() {
        saleDetails = fetchData.salesDetails ?? [];
        salesPayments = fetchData.salesPayments ?? [];
        codigopessoa = fetchData.codigopessoa.toString();
        nomepessoa = fetchData.nomepessoa.toString();
        empresaCodigo = fetchData.empresacodigo.toString();
        empresaNome = fetchData.empresanome.toString();
        numeroPedido = fetchData.numero.toString();
        numeromovimento = fetchData.numeromovimento.toString();
        terminal = fetchData.terminal.toString();
        valortotalmovimento = fetchData.valortotalmovimento ?? 0.0;
        valorsubtotal = fetchData.valortotalprodutos ?? 0.0;
        outrasdespesas = fetchData.valoroutrasdespesas ?? 0.0;
        valordesconto = fetchData.valordescontomovimento ?? 0.0;
        valorfrete = fetchData.valorfrete ?? 0.0;
        margem = fetchData.margem ?? 0.0;
      });
    }
    print(saleDetails!.first.codigopessoa);
  }

  Future<void> loadData() async {
    await Future.wait([_loadSavedUrlBasic(), _loadSavedSellerId()]);
    await Future.wait([fetchDataSaleDetails()]);
    setState(() {
      isLoading = false;
    });
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Style.tertiaryColor,
          fontSize: Style.height_8(context),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _cell(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: Style.height_8(context)),
        softWrap: true,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
