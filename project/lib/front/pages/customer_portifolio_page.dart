import 'package:flutter/material.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/structure/card_interactive_of_list.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/pages/customer_informations_page.dart';
import 'package:project/front/pages/seller_monitor_page.dart';
import 'package:project/front/style/style.dart';

class CustomerPortifolioPage extends StatefulWidget {
  const CustomerPortifolioPage({super.key});

  @override
  State<CustomerPortifolioPage> createState() => _CustomerPortifolioPageState();
}

class _CustomerPortifolioPageState extends State<CustomerPortifolioPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
            child: Scaffold(
              drawer: CustomDrawer(),
              body: ListView(
                children: [
                  Navbar(text: 'Carteira de Clientes', children: [
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
                            hintText: 'Pesquise pelo cliente',
                            hintStyle: WidgetStatePropertyAll(TextStyle(
                                fontSize: Style.height_12(context),
                                color: Style.quarantineColor)),
                            backgroundColor:
                                WidgetStatePropertyAll(Style.disabledColor),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCard(
                                text: 'Nome do Cliente',
                                fontSize: Style.height_7(context),
                                textAlign: TextAlign.left,
                                color: Style.quarantineColor,
                              ),
                              TextCard(
                                text: '(Nome do Cliente)',
                                fontSize: Style.height_10(context),
                                textAlign: TextAlign.left,
                                color: Style.primaryColor,
                                FontWeight: FontWeight.bold,
                              ),
                              TextCard(
                                text: 'Código do Cliente',
                                fontSize: Style.height_7(context),
                                textAlign: TextAlign.left,
                                color: Style.quarantineColor,
                              ),
                              TextCard(
                                text: '(Código)',
                                fontSize: Style.height_10(context),
                                textAlign: TextAlign.left,
                                color: Style.primaryColor,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextCard(
                                text: 'Crédito',
                                fontSize: Style.height_7(context),
                                textAlign: TextAlign.right,
                                color: Style.quarantineColor,
                              ),
                              TextCard(
                                text: '0,00',
                                fontSize: Style.height_10(context),
                                textAlign: TextAlign.right,
                                color: Style.primaryColor,
                                FontWeight: FontWeight.bold,
                              ),
                              TextCard(
                                text: 'Adimplência',
                                fontSize: Style.height_7(context),
                                textAlign: TextAlign.right,
                                color: Style.quarantineColor,
                              ),
                              Icon(
                                Icons.price_check_outlined,
                                color: Style.sucefullColor,
                                size: Style.height_20(context),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => CustomerInformations(),
                        ),
                      );
                    },
                  ),
                  CardInteractiveOfList(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCard(
                                text: 'Nome do Cliente',
                                fontSize: Style.height_7(context),
                                textAlign: TextAlign.left,
                                color: Style.quarantineColor,
                              ),
                              TextCard(
                                text: '(Nome do Cliente)',
                                fontSize: Style.height_10(context),
                                textAlign: TextAlign.left,
                                color: Style.primaryColor,
                                FontWeight: FontWeight.bold,
                              ),
                              TextCard(
                                text: 'Código do Cliente',
                                fontSize: Style.height_7(context),
                                textAlign: TextAlign.left,
                                color: Style.quarantineColor,
                              ),
                              TextCard(
                                text: '(Código)',
                                fontSize: Style.height_10(context),
                                textAlign: TextAlign.left,
                                color: Style.primaryColor,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextCard(
                                text: 'Crédito',
                                fontSize: Style.height_7(context),
                                textAlign: TextAlign.right,
                                color: Style.quarantineColor,
                              ),
                              TextCard(
                                text: '0,00',
                                fontSize: Style.height_10(context),
                                textAlign: TextAlign.right,
                                color: Style.primaryColor,
                                FontWeight: FontWeight.bold,
                              ),
                              TextCard(
                                text: 'Adimplência',
                                fontSize: Style.height_7(context),
                                textAlign: TextAlign.right,
                                color: Style.quarantineColor,
                              ),
                              Icon(
                                Icons.money_off_rounded,
                                color: Style.errorColor,
                                size: Style.height_20(context),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => CustomerInformations(),
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
                  builder: (context) => SellerMonitorPage(),
                ),
              );
              return true;
            }));
  }
}
