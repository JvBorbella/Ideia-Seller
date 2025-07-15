import 'package:flutter/material.dart';
import 'package:project/back/seller_monitor/seller_monitor_data.dart';
import 'package:project/front/components/buttons/modal_button.dart';
import 'package:project/front/pages/customer_portifolio_page.dart';
import 'package:project/front/pages/sale_monitor_page.dart';
import 'package:project/front/pages/seller_monitor_page.dart';
import 'package:project/front/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String token = '';
  String login = '';
  String image = '';
  String url = '';
  String urlBasic = '';
  String usuario = '';

  String empresaid = '';
  String cpf = '';

  bool flagNotify = true;
  bool _isExpandedConfig = false;
  bool _isExpandedMonit = false;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _loadSavedUrl();
    // _loadSavedToken();
    // _loadSavedLogin();
    // _loadSavedImage();
    // _loadSavedUrlBasic();
    // _loadSavedEmail();
    // _loadSavedFlagNotify();
    // _loadSavedUser;
    // fetchDataSellerMonitor();
    loadData();
  }

  void _closeDrawer() {
    //Função para fechar o modal
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: WillPopScope(
            child: Drawer(
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        // height: Style.DrawerHeaderSize(context),
                        decoration: BoxDecoration(color: Style.primaryColor),
                        child: Container(
                          padding: EdgeInsets.all(Style.height_15(context)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: _closeDrawer,
                                    icon: Icon(Icons.close),
                                    iconSize:
                                        Style.IconCloseDrawerSize(context),
                                    alignment: Alignment.topRight,
                                    style: ButtonStyle(
                                      iconColor: WidgetStatePropertyAll(
                                          Style.tertiaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: Style.SalesCardSpace(context),
                              // ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: Style.height_25(context))),
                                      Container(
                                        width: Style.AccountNameWidth(context),
                                        height: Style.AccountNameWidth(context),
                                        // decoration: BoxDecoration(shape: BoxShape.circle),
                                        child: ClipOval(
                                            child: imagem.isEmpty
                                                ? Image.asset(
                                                    'assets/images/user.png',
                                                    color: Style.tertiaryColor,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    fit: BoxFit.cover,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                  )
                                                : Image.network(
                                                    imagem,
                                                    alignment:
                                                        Alignment.topCenter,
                                                    fit: BoxFit.cover,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                  ) // Exibe a imagem
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Style.height_10(context),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Olá, ' + login + '!',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontSize:
                                                  Style.LoginFontSize(context),
                                              color: Style.tertiaryColor,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            //'${empresa_codigo} - ${empresa_nome}',
                                            'E1 - Empresa Fictícia',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontSize:
                                                  Style.height_12(context),
                                              color: Style.tertiaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            //email,
                                            'suporte@ideiatecnologia.com.br',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Regular',
                                              fontSize:
                                                  Style.EmailFontSize(context),
                                              color: Style.tertiaryColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Style.ModalButtonSpace(context),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    child: ModalButton(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListBody(
                  children: [
                    Container(
                      // padding: EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Style.height_5(context),
                          ),
                          // TextButton(
                          //   onPressed: () {},
                          //   child: Text(
                          //     'Promoções Relâmpago',
                          //     style: TextStyle(
                          //         color: Style.primaryColor,
                          //         fontSize: Style.ButtonDrawerSize(context),
                          //         fontFamily: 'Poppins-Medium'),
                          //   ),
                          // ),

                          SizedBox(
                            height: Style.height_15(context),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isExpandedMonit = !_isExpandedMonit;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: Style.height_10(context)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: Style.height_10(context),
                                          ),
                                          Row(
                                            children: [
                                              if (_isExpandedMonit)
                                                Transform.rotate(
                                                  angle:
                                                      3.1416, // 180 graus em radianos (π)
                                                  child: Icon(
                                                    Icons
                                                        .arrow_drop_down_outlined,
                                                    size: Style.height_20(
                                                        context),
                                                    color: Style.primaryColor,
                                                  ),
                                                )
                                              else
                                                Icon(
                                                  Icons
                                                      .arrow_drop_down_outlined,
                                                  size:
                                                      Style.height_20(context),
                                                  color: Style.primaryColor,
                                                ),
                                              SizedBox(
                                                width: Style.width_10(context),
                                              ),
                                              Text(
                                                'Monitores',
                                                style: TextStyle(
                                                    fontSize: Style.height_15(
                                                        context),
                                                    color: Style.primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          AnimatedContainer(
                                            padding: EdgeInsets.only(
                                                left: Style.height_12(context)),
                                            duration:
                                                Duration(milliseconds: 300),
                                            // height: _isExpanded
                                            //     ? Style.height_50(context)
                                            //     : 0,
                                            child: Visibility(
                                                visible: _isExpandedMonit,
                                                maintainAnimation: true,
                                                maintainState: true,
                                                maintainSize: false,
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SellerMonitorPage(),
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            'Monitor do Vendedor',
                                                            style: TextStyle(
                                                              color: Style
                                                                  .secondaryColor,
                                                              fontSize: Style
                                                                  .height_12(
                                                                      context),
                                                              fontFamily:
                                                                  'Poppins-Medium',
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Style.height_5(
                                                                  context),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SaleMonitor(vendedorpessoa_id: pessoa_id,),
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            'Vendas',
                                                            style: TextStyle(
                                                                color: Style
                                                                    .secondaryColor,
                                                                fontSize: Style
                                                                    .height_12(
                                                                        context),
                                                                fontFamily:
                                                                    'Poppins-Medium'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Style.height_5(
                                                                  context),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        CustomerPortifolioPage(),
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            'Carteira de Clientes',
                                                            style: TextStyle(
                                                                color: Style
                                                                    .secondaryColor,
                                                                fontSize: Style
                                                                    .height_12(
                                                                        context),
                                                                fontFamily:
                                                                    'Poppins-Medium'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Style.height_15(context),
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () {
                          //         setState(() {
                          //           _isExpandedConfig = !_isExpandedConfig;
                          //         });
                          //       },
                          //       child: Column(
                          //         children: [
                          //           Container(
                          //             padding: EdgeInsets.only(
                          //                 left: Style.height_10(context)),
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 Text(
                          //                   'ℹ Ajuda',
                          //                   style: TextStyle(
                          //                     fontSize:
                          //                         Style.height_15(context),
                          //                     fontWeight: FontWeight.bold,
                          //                     color: Style.secondaryColor,
                          //                   ),
                          //                 ),
                          //                 AnimatedContainer(
                          //                   padding: EdgeInsets.only(
                          //                       left: Style.height_12(context)),
                          //                   duration:
                          //                       Duration(milliseconds: 300),
                          //                   // height: _isExpanded
                          //                   //     ? Style.height_50(context)
                          //                   //     : 0,
                          //                   child: Visibility(
                          //                       visible: _isExpandedConfig,
                          //                       maintainAnimation: true,
                          //                       maintainState: true,
                          //                       maintainSize: false,
                          //                       child: Column(
                          //                         children: [
                          //                           Row(
                          //                             children: [
                          //                               TextButton(
                          //                                 onPressed: () {},
                          //                                 child: Text(
                          //                                   'Manual de uso do aplicativo',
                          //                                   style: TextStyle(
                          //                                       color: Style
                          //                                           .secondaryColor,
                          //                                       fontSize: Style
                          //                                           .height_12(
                          //                                               context),
                          //                                       fontFamily:
                          //                                           'Poppins-Medium'),
                          //                                 ),
                          //                               ),
                          //                             ],
                          //                           ),
                          //                         ],
                          //                       )),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )),
            onWillPop: () async {
              _closeDrawer();
              return true;
            }));
  }

  Future<void> _loadSavedUrl() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrl = await sharedPreferences.getString('url') ?? '';
    setState(() {
      url = savedUrl;
    });
  }

  Future<void> _loadSavedToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedToken = await sharedPreferences.getString('token') ?? '';
    setState(() {
      token = savedToken;
    });
  }

  Future<void> _loadSavedFlagNotify() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool savedFlagNotify = sharedPreferences.getBool('flagNotify') ??
        true; // Carrega o valor salvo (padrão: true)
    setState(() {
      flagNotify = savedFlagNotify; // Atualiza o estado com o valor salvo
    });
  }

  Future<void> _loadSavedLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedLogin = await sharedPreferences.getString('login') ?? '';
    setState(() {
      login = savedLogin;
    });
  }

  Future<void> _loadSavedImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedImage = await sharedPreferences.getString('image') ?? '';
    setState(() {
      image = savedImage;
    });
  }

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
  }

  Future<void> _loadSavedEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedEmail = await sharedPreferences.getString('email') ?? '';
    setState(() {
      email = savedEmail;
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
    await Future.wait([_loadSavedLogin()]);
    //await Future.wait([fetchDataSellerMonitor()]);
  }
}
