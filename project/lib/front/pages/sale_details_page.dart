import 'package:flutter/material.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/structure/informative_card.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/components/texts/titles.dart';
import 'package:project/front/pages/sale_list_page.dart';
import 'package:project/front/style/style.dart';

class SaleDetails extends StatefulWidget {
  const SaleDetails({super.key});

  @override
  State<SaleDetails> createState() => _SaleDetailsState();
}

class _SaleDetailsState extends State<SaleDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
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
                        Titles(
                            text: '(CÓDIGO) - (NOME DO CLIENTE)',
                            fontSize: Titles.h3(context)),
                        Titles(
                            text: '(E1) - (Nome da Empresa)',
                            fontSize: Style.height_10(context)),
                        Titles(
                            text: '(Nº do Pedido)',
                            fontSize: Style.height_10(context)),
                        Titles(
                          text: '(Nº do Movimento)',
                          fontSize: Style.height_10(context),
                          FontWeight: FontWeight.bold,
                        ),
                        Titles(
                            text: '(Terminal)',
                            fontSize: Style.height_10(context)),
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
                              text: 'RS 000.000,00',
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
                              text: 'RS 000,00',
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
                              text: 'RS 000,00',
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
                              text: 'RS 000,00',
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
                              text: 'RS 000,00',
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
                              text: '0.00%',
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
                          borderRadius: BorderRadius.all(
                              Radius.circular(Style.height_10(context)))),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                              color: Style.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(Style.height_10(context)),
                                topRight:
                                    Radius.circular(Style.height_10(context)),
                              )),
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                'Meio de Pgto.',
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
                                'Cond. Pgto.',
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
                                'Valor',
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
                                '',
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
                                '',
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
                                '',
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
                          borderRadius: BorderRadius.all(
                              Radius.circular(Style.height_10(context)))),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                              color: Style.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(Style.height_10(context)),
                                topRight:
                                    Radius.circular(Style.height_10(context)),
                              )),
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              child: Text(
                                'Cód.',
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
                                'Nome',
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
                                'Qtde.',
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
                                'Exp.',
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
                                'Desc.',
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
                                'Valor',
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
                                '',
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
                                '',
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
                                '',
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
                                '',
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
                                '',
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
                                '',
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
                ],
              ),
            ),
            onWillPop: () async {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SaleListPage(),
                ),
              );
              return true;
            }));
  }
}
