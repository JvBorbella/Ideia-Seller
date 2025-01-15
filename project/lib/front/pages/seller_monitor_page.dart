import 'package:flutter/material.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/structure/form_card.dart';
import 'package:project/front/components/structure/interactive_card.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/components/texts/titles.dart';
import 'package:project/front/pages/customer_portifolio_page.dart';
import 'package:project/front/pages/sale_monitor_page.dart';
import 'package:project/front/style/style.dart';

class SellerMonitorPage extends StatefulWidget {
  const SellerMonitorPage({super.key});

  @override
  State<SellerMonitorPage> createState() => _SellerMonitorPageState();
}

class _SellerMonitorPageState extends State<SellerMonitorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
            child: Scaffold(
                drawer: Drawer(
                  child: CustomDrawer(),
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
                body: ListView(
                  children: [
                    Navbar(
                      text: 'Monitor do Vendedor',
                      children: [
                        DrawerButton(
                          style: ButtonStyle(
                              iconSize: WidgetStatePropertyAll(
                                  Style.SizeDrawerButton(context)),
                              iconColor:
                                  WidgetStatePropertyAll(Style.tertiaryColor),
                              padding: WidgetStatePropertyAll(EdgeInsets.all(
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
                        child: Image.asset(
                          'assets/images/user.png',
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
                      text: '(CÓDIGO)',
                      fontSize: Titles.h3(context),
                    ),
                    Titles(
                      text: '(NOME DO VENDEDOR)',
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
                                  text: '000.000,00',
                                  fontSize: Style.height_12(context),
                                  textAlign: TextAlign.right,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: '000.000,00',
                                  fontSize: Style.height_12(context),
                                  textAlign: TextAlign.right,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: '000.000,00',
                                  fontSize: Style.height_12(context),
                                  textAlign: TextAlign.right,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: '000.000,00',
                                  fontSize: Style.height_12(context),
                                  textAlign: TextAlign.right,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: '000.000,00',
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
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                SaleMonitor(),
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
                                  text: '10',
                                  fontSize: Style.height_12(context),
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: '30',
                                  fontSize: Style.height_12(context),
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: '20',
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
                            builder: (context) =>
                                CustomerPortifolioPage(),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextCard(
                                  text: 'Meta Diária',
                                  fontSize: Style.height_8(context),
                                  color: Style.quarantineColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCard(
                                    text: '5.000',
                                    fontSize: Style.height_12(context),
                                    FontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Style.sucefullColor,
                                    size: Style.height_12(context),
                                  ),
                                ],
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextCard(
                                  text: 'Meta Mensal',
                                  fontSize: Style.height_8(context),
                                  color: Style.quarantineColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCard(
                                    text: '150.000',
                                    fontSize: Style.height_12(context),
                                    FontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Style.sucefullColor,
                                    size: Style.height_12(context),
                                  ),
                                ],
                              ),
                            ]),
                      ],
                      Text: 'Metas Atingidas',
                      icon: Icons.track_changes_outlined,
                    ),
                    SizedBox(
                      height: Style.height_10(context),
                    )
                  ],
                )),
            onWillPop: () async {
              return false;
            }));
  }
}
