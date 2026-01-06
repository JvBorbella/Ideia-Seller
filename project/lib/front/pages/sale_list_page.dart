import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/back/sales_list_functions/sale_list_data.dart';
import 'package:project/back/seller_monitor/sales.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/inputs/search_bar.dart';
import 'package:project/front/components/structure/card_interactive_of_list.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/pages/sale_details_page.dart';
import 'package:project/front/pages/sale_monitor_page.dart';
import 'package:project/front/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaleListPage extends StatefulWidget {
  final pessoa_id;
  final period;
  const SaleListPage({Key? key, this.pessoa_id, this.period});

  @override
  State<SaleListPage> createState() => _SaleListPageState();
}

class _SaleListPageState extends State<SaleListPage> {
  TextEditingController searchController = TextEditingController();
  String urlBasic = '', vendedorId = '', selectedOptionChild = '', period = '';
  bool isLoading = true, flagClear = false, flagLoad = true;
  int flagToday = 0,
      flagYesterday = 0,
      flagWeek = 0,
      flagMonth = 0,
      flagFilter = 4;

  List<GetSales> sales = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('AIDI - ${widget.pessoa_id}');
    loadData();
  }

  NumberFormat currencyFormatDefault =
      NumberFormat.currency(locale: 'pt_BR', symbol: '');

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
                  builder: (context) => SaleMonitor(vendedorpessoa_id: vendedorId),
                ),
              );
        },
      child: Scaffold(
              drawer: CustomDrawer(),
              body: Column(
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
                          SearchBarDefault(
                            controller: searchController,
                            hintText: 'Pesquise pela venda',
                            onChanged: (value) {
                              if (searchController.text.isNotEmpty) {
                                setState(() {
                                  flagClear = true;
                                });
                              } else {
                                setState(() {
                                  flagClear = false;
                                });
                              }
                            },
                            onPressedPrefix: () async {
                              setState(() {
                                flagLoad = true;
                              });
                              await fetchDataSaleList(
                                  flagFilter, period, searchController.text);
                            },
                            onSubmited: (value) async {
                              setState(() {
                                flagLoad = true;
                              });
                              await fetchDataSaleList(
                                  flagFilter, period, searchController.text);
                            },
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (flagClear == true)
                                  IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        flagLoad = true;
                                      });
                                      searchController.clear();
                                      await fetchDataSaleList(
                                          flagFilter, period, '');
                                    },
                                    icon: Icon(Icons.backspace_rounded),
                                    color: Style.errorColor,
                                  ),
                                IconButton(
                                  onPressed: () async {
                                    await modalFilter();
                                  },
                                  icon: Icon(Icons.filter_alt_rounded),
                                  color: Style.secondaryColor,
                                  iconSize: Style.height_25(context),
                                )
                              ],
                            ),
                            flagClear: flagClear,
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
                  if (flagLoad)
                    Center(
                        child: Container(
                            height:
                                Style.CircularProgressIndicatorWidth(context),
                            width:
                                Style.CircularProgressIndicatorWidth(context),
                            child: CircularProgressIndicator(
                              year2023: false,
                              strokeWidth:
                                  Style.CircularProgressIndicatorSize(context),
                            )))
                  else
                    Expanded(
                      child: ListView.builder(
                        //physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sales.length,
                        itemBuilder: (context, index) {
                          return CardInteractiveOfList(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        //text: saleList[index].numeromovimento,
                                        text: sales[index]
                                            .numeromovimento
                                            .toString(),
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
                                          //text: (saleList[index].datahora).toString(),
                                          text:
                                              '${DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.parse(sales[index].datacadastro))}',
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
                                        text: sales[index]
                                            .nomecondicaopagamento
                                            .toString(),
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
                                        text: sales[index].flagservico == 1
                                            ? 'Sim'
                                            : 'Não',
                                        fontSize: Style.height_10(context),
                                        color: Style.primaryColor,
                                        textAlign: TextAlign.center,
                                        FontWeight: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                  // Column(
                                  //   children: [
                                  //     TextCard(
                                  //       text: 'Margem',
                                  //       fontSize: Style.height_7(context),
                                  //       color: Style.quarantineColor,
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //     TextCard(
                                  //       //text: (saleList[index].margem).toString(),
                                  //       text: '',
                                  //       fontSize: Style.height_10(context),
                                  //       color: Style.primaryColor,
                                  //       textAlign: TextAlign.center,
                                  //       FontWeight: FontWeight.bold,
                                  //     )
                                  //   ],
                                  // ),
                                  Column(
                                    children: [
                                      TextCard(
                                        text: 'Valor',
                                        fontSize: Style.height_7(context),
                                        color: Style.quarantineColor,
                                        textAlign: TextAlign.center,
                                      ),
                                      TextCard(
                                        //text: (saleList[index].valortotal).toString(),
                                        text: currencyFormatDefault
                                            .format(sales[index].valortotal)
                                            .toString(),
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
                                        //text: saleList[index].pessoa_nome,
                                        text:
                                            sales[index].nomepessoa.toString(),
                                        fontSize: Style.height_12(context),
                                        color: Style.primaryColor,
                                        textAlign: TextAlign.center,
                                        FontWeight: FontWeight.bold,
                                      ),
                                      if (sales[index].flagdevolucaovenda == 1)
                                        Text(
                                          'DEVOLUÇÂO',
                                          style: TextStyle(
                                              color: Style.errorColor),
                                        ),
                                      if (sales[index].flagcancelado == 1)
                                        Text(
                                          'CANCELADA',
                                          style: TextStyle(
                                              color: Style.errorColor),
                                        )
                                    ],
                                  ),
                                ],
                              )
                            ],
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => SaleDetails(
                                      movimentosaidaId:
                                          sales[index].movimentosaida_id),
                                ),
                              );
                            },
                          );
                        },
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

  Future<void> _loadSavedSellerId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedSellerId =
        await sharedPreferences.getString('vendedor_id') ?? '';
    setState(() {
      vendedorId = savedSellerId;
    });
  }

  // Future<void> fetchDataSaleList() async {
  //   List<SaleList>? fetchedData =
  //       await DataServiceSaleList.fetchDataSaleList(widget.pessoa_id, urlBasic);
  //   if (fetchedData != null) {
  //     setState(() {
  //       saleList = fetchedData;
  //     });
  //   }
  // }

  Future<void> fetchDataSaleList(
      int flagFilter, String period, String search) async {
    final fetchData = await SalesResultValues.fetchDataSales(
        urlBasic, vendedorId, period, flagFilter, searchController.text);
    if (fetchData != null) {
      setState(() {
        sales = fetchData.sales;
        flagLoad = false;
      });
    }
  }

  Future<void> loadData() async {
    await Future.wait([_loadSavedUrlBasic(), _loadSavedSellerId()]);
    period = widget.period;
    await Future.wait(
        [fetchDataSaleList(flagFilter, period, searchController.text)]);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> modalFilter() async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              title: const Text('Filtrar'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: Style.height_5(context)),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Style.height_5(context)),
                                            color: Style.errorColor),
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: Image.asset(
                                              'assets/icons/icon_remove.png'),
                                          style: ButtonStyle(
                                              iconColor: WidgetStatePropertyAll(
                                                  Style.tertiaryColor)),
                                        ),
                                      ),
                                    ],
                                  )),
                              PopupMenuDivider(
                                height: Style.height_1(context),
                              ),
                              const PopupMenuItem<String>(
                                labelTextStyle: WidgetStatePropertyAll(
                                    TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins-Medium',
                                        color: Style.primaryColor)),
                                value: 'Hoje',
                                child: Text(
                                  'Hoje',
                                ),
                              ),
                              PopupMenuDivider(
                                height: Style.height_1(context),
                              ),
                              const PopupMenuItem<String>(
                                labelTextStyle: WidgetStatePropertyAll(
                                    TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins-Medium',
                                        color: Style.primaryColor)),
                                value: 'Ontem',
                                child: Text('Ontem'),
                              ),
                              PopupMenuDivider(
                                height: Style.height_1(context),
                              ),
                              const PopupMenuItem<String>(
                                labelTextStyle: WidgetStatePropertyAll(
                                    TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins-Medium',
                                        color: Style.primaryColor)),
                                value: 'Semana',
                                child: Text('Semana'),
                              ),
                              PopupMenuDivider(
                                height: Style.height_1(context),
                              ),
                              const PopupMenuItem<String>(
                                labelTextStyle: WidgetStatePropertyAll(
                                    TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins-Medium',
                                        color: Style.primaryColor)),
                                value: 'Mês',
                                child: Text('Mês'),
                              ),
                              PopupMenuDivider(
                                height: Style.height_1(context),
                              ),
                              const PopupMenuItem<String>(
                                labelTextStyle: WidgetStatePropertyAll(
                                    TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins-Medium',
                                        color: Style.primaryColor)),
                                value: 'Mês Anterior',
                                child: Text('Mês Anterior'),
                              ),
                            ],
                            onSelected: (String value) async {
                              if (value == 'Hoje') {
                                setModalState(() {
                                  flagToday = 1;
                                  flagMonth = 0;
                                  period = 'm.data%20=%20CURRENT_DATE';
                                });
                              } else if (value == 'Ontem') {
                                setModalState(() {
                                  flagYesterday = 1;
                                  flagMonth = 0;
                                  period = 'm.data%20=%20CURRENT_DATE%20-%201';
                                });
                              } else if (value == 'Semana') {
                                setModalState(() {
                                  flagWeek = 1;
                                  flagMonth = 0;
                                  period =
                                      'm.data%20=%20ADDDATE(CURDATE(),INTERVAL%20(DAYOFWEEK(CURDATE())-1)*(-1)%20day)';
                                });
                              } else if (value == 'Mês') {
                                setModalState(() {
                                  flagMonth = 1;
                                  period =
                                      'm.data%20>=%20ADDDATE(CURDATE(),INTERVAL%20(DAYOFMONTH(CURDATE())-1)*(-1)%20day)';
                                });
                              } else if (value == 'Mês Anterior') {
                                setModalState(() {
                                  flagMonth = 1;
                                  period =
                                      '''m.data%20%3E=%20DATE_FORMAT(CURDATE()%20-%20INTERVAL%201%20MONTH,%20'%Y-%m-01')%20AND%20m.data%20%3C=%20LAST_DAY(CURDATE()%20-%20INTERVAL%201%20MONTH)''';
                                });
                              }
                              setModalState(() {
                                selectedOptionChild = value;
                              });
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_month_sharp,
                                    color: Style.secondaryColor,
                                    size: Style.height_20(context),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Style.height_1(context)),
                                    child: Text(
                                      selectedOptionChild == ''
                                          ? 'Selecione o Período'
                                          : selectedOptionChild,
                                      style: TextStyle(
                                          fontSize: Style.height_15(context),
                                          color: Style.secondaryColor),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text('Canceladas'),
                    value: flagFilter == 1,
                    onChanged: (bool? newValue) async {
                      setModalState(() {
                        flagFilter = (newValue ?? false) ? 1 : 0;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Devolvidas'),
                    value: flagFilter == 2,
                    onChanged: (bool? newValue) async {
                      setModalState(() {
                        flagFilter = (newValue ?? false) ? 2 : 0;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Faturadas'),
                    value: flagFilter == 3,
                    onChanged: (bool? newValue) async {
                      setModalState(() {
                        flagFilter = (newValue ?? false) ? 3 : 0;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Todas'),
                    value: flagFilter == 4,
                    onChanged: (bool? newValue) async {
                      setModalState(() {
                        flagFilter = (newValue ?? false) ? 4 : 0;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      flagLoad = true;
                    });
                    fetchDataSaleList(
                        flagFilter, period, searchController.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Aplicar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
