import 'package:flutter/material.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/structure/informative_card.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/components/texts/titles.dart';
import 'package:project/front/pages/customer_portifolio_page.dart';
import 'package:project/front/style/style.dart';

class CustomerInformations extends StatefulWidget {
  const CustomerInformations({super.key});

  @override
  State<CustomerInformations> createState() => _CustomerInformationsState();
}

class _CustomerInformationsState extends State<CustomerInformations> {
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
                                  fontSize: Style.height_7(context),
                                  color: Style.quarantineColor,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: '000.000,00',
                                  fontSize: Style.height_10(context),
                                  color: Style.primaryColor,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextCard(
                                  text: 'Devolução',
                                  fontSize: Style.height_7(context),
                                  color: Style.quarantineColor,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: '000.000,00',
                                  fontSize: Style.height_10(context),
                                  color: Style.primaryColor,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextCard(
                                  text: 'Crédito',
                                  fontSize: Style.height_7(context),
                                  color: Style.quarantineColor,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: '000.000,00',
                                  fontSize: Style.height_10(context),
                                  color: Style.primaryColor,
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
                                child: Icon(
                                  Icons.error,
                                  color: Style.errorColor,
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
            onWillPop: () async {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => CustomerPortifolioPage(),
                ),
              );
              return true;
            }));
  }
}
