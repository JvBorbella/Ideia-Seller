import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/back/seller_monitor/seller_monitor_data.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/structure/form_card.dart';
import 'package:project/front/components/structure/interactive_card.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/components/texts/titles.dart';
import 'package:project/front/pages/customer_portifolio_page.dart';
import 'package:project/front/pages/sale_monitor_page.dart';
import 'package:project/front/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerMonitorPage extends StatefulWidget {
  final userController;

  const SellerMonitorPage({Key? key, this.userController});

  @override
  State<SellerMonitorPage> createState() => _SellerMonitorPageState();
}

class _SellerMonitorPageState extends State<SellerMonitorPage> {
  String usuario = '';
  String urlBasic = '';

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
                        child: imagem.isEmpty ? Image.asset(
                          'assets/images/user.png',
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ) : Image.network(
                          imagem,
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
                                  text: currencyFormat.format(vendashoje).toString(),
                                  fontSize: Style.height_12(context),
                                  textAlign: TextAlign.right,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: currencyFormat.format(vendasontem).toString(),
                                  fontSize: Style.height_12(context),
                                  textAlign: TextAlign.right,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: currencyFormat.format(vendassemana).toString(),
                                  fontSize: Style.height_12(context),
                                  textAlign: TextAlign.right,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: currencyFormat.format(vendasmes).toString(),
                                  fontSize: Style.height_12(context),
                                  textAlign: TextAlign.right,
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: currencyFormat.format(vendasmesanterior).toString(),
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
                            builder: (context) => SaleMonitor(
                              vendedorpessoa_id: pessoa_id
                            ),
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
                                  text: clientes_inadimplentes.toString(),
                                  fontSize: Style.height_12(context),
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: clientes_adimplentes.toString(),
                                  fontSize: Style.height_12(context),
                                  FontWeight: FontWeight.bold,
                                ),
                                TextCard(
                                  text: clientes_restantes.toString(),
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

  Future<void> fetchDataSellerMonitor() async {
    Map<String?, dynamic?> fetchedData =
        await DataServiceSellerMonitor.fetchDataSellerMonitor(
            usuario, urlBasic);
    setState(() {
      pessoa_id = fetchedData['pessoa_id'] ?? '';
      codigo = fetchedData['codigo'] ?? '';
      nome = fetchedData['nome'] ?? '';
      email = fetchedData['email'] ?? '';
      empresa_id = fetchedData['empresa_id'] ?? '';
      empresa_codigo = fetchedData['empresa_codigo'] ?? '';
      empresa_nome = fetchedData['empresa_nome'] ?? '';
      imagem = fetchedData['imagem'] ?? '';
      vendashoje = fetchedData['vendashoje'] ?? 0.0;
      vendasontem = fetchedData['vendasontem'] ?? 0.0;
      vendassemana = fetchedData['vendassemana'] ?? 0.0;
      vendasmes = fetchedData['vendasmes'] ?? 0.0;
      vendasmesanterior = fetchedData['vendasmesanterior'] ?? 0.0;
      clientes_inadimplentes = fetchedData['clientes_inadimplentes'] ?? 0;
      clientes_adimplentes = fetchedData['clientes_adimplentes'] ?? 0;
      clientes_restantes = fetchedData['clientes_restantes'] ?? 0;
    });
  }

  Future<void> loadData() async {
    await Future.wait([_loadSavedUrlBasic()]);
    await Future.wait([_loadSavedUser()]);
    await Future.wait([fetchDataSellerMonitor()]);
    setState(() {
      isLoading = false;
    });
  }
}
