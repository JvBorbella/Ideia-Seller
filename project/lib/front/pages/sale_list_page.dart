import 'package:flutter/material.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/structure/card_interactive_of_list.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/pages/sale_details_page.dart';
import 'package:project/front/pages/sale_monitor_page.dart';
import 'package:project/front/style/style.dart';

class SaleListPage extends StatefulWidget {
  const SaleListPage({super.key});

  @override
  State<SaleListPage> createState() => _SaleListPageState();
}

class _SaleListPageState extends State<SaleListPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
            child: Scaffold(
              drawer: CustomDrawer(),
              body: ListView(
                children: [
                  Navbar(text: 'Histórico de Vendas', children: [
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
                        children: [
                          SearchBar(
                            onSubmitted: (value) async {},
                            controller: searchController,
                            textStyle: WidgetStatePropertyAll(
                                TextStyle(fontSize: Style.height_15(context))),
                            enabled: true,
                            leading: IconButton(
                              onPressed: () async {},
                              icon: Icon(Icons.search),
                              color: Style.primaryColor,
                              iconSize: Style.height_30(context),
                            ),
                            hintText: 'Pesquise pelo Nº da venda',
                            hintStyle: WidgetStatePropertyAll(TextStyle(
                                fontSize: Style.height_12(context),
                                color: Style.quarantineColor)),
                            backgroundColor:
                                WidgetStatePropertyAll(Style.disabledColor),
                          ),
                          SizedBox(
                            height: Style.height_10(context),
                          ),
                          Text(
                            'OBS: O Histórico das vendas é retornado com base no período selecionado na tela anterior!',
                            style: TextStyle(
                                color: Style.quarantineColor,
                                fontSize: Style.height_10(context)),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: Style.height_10(context),
                  ),
                  CardInteractiveOfList(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              TextCard(
                                text: 'Número',
                                fontSize: Style.height_7(context),
                                color: Style.quarantineColor,
                                textAlign: TextAlign.center,
                              ),
                              TextCard(
                                text: '000000',
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                textAlign: TextAlign.center,
                                FontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                          Container(
                            width: Style.width_100(context),
                            child: Column(
                              children: [
                                TextCard(
                                  text: 'Data/Hora',
                                  fontSize: Style.height_7(context),
                                  color: Style.quarantineColor,
                                  textAlign: TextAlign.center,
                                ),
                                TextCard(
                                  text: '00/00/0000 00:00:00',
                                  fontSize: Style.height_10(context),
                                  color: Style.primaryColor,
                                  textAlign: TextAlign.center,
                                  FontWeight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              TextCard(
                                text: 'Meio Pgto.',
                                fontSize: Style.height_7(context),
                                color: Style.quarantineColor,
                                textAlign: TextAlign.center,
                              ),
                              TextCard(
                                text: 'DINHEIRO',
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                textAlign: TextAlign.center,
                                FontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              TextCard(
                                text: 'Serviços?',
                                fontSize: Style.height_7(context),
                                color: Style.quarantineColor,
                                textAlign: TextAlign.center,
                              ),
                              TextCard(
                                text: 'Não',
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                textAlign: TextAlign.center,
                                FontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              TextCard(
                                text: 'Margem',
                                fontSize: Style.height_7(context),
                                color: Style.quarantineColor,
                                textAlign: TextAlign.center,
                              ),
                              TextCard(
                                text: '0.00%',
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                textAlign: TextAlign.center,
                                FontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              TextCard(
                                text: 'Valor',
                                fontSize: Style.height_7(context),
                                color: Style.quarantineColor,
                                textAlign: TextAlign.center,
                              ),
                              TextCard(
                                text: '000,00',
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                textAlign: TextAlign.center,
                                FontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Style.height_2(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              TextCard(
                                text: 'Nome do cliente',
                                fontSize: Style.height_7(context),
                                color: Style.quarantineColor,
                                textAlign: TextAlign.center,
                              ),
                              TextCard(
                                text: '(NOME DO CLIENTE)',
                                fontSize: Style.height_12(context),
                                color: Style.primaryColor,
                                textAlign: TextAlign.center,
                                FontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => SaleDetails(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            onWillPop: () async {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SaleMonitor(),
                ),
              );
              return true;
            }));
  }
}
