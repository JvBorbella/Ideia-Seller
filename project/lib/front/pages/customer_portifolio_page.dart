import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/back/customer_base/customer_base.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/inputs/search_bar.dart';
import 'package:project/front/components/structure/card_interactive_of_list.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/pages/customer_informations_page.dart';
import 'package:project/front/pages/seller_monitor_page.dart';
import 'package:project/front/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerPortifolioPage extends StatefulWidget {
  const CustomerPortifolioPage({super.key});

  @override
  State<CustomerPortifolioPage> createState() => _CustomerPortifolioPageState();
}

class _CustomerPortifolioPageState extends State<CustomerPortifolioPage> {
  List<CustomerBase> customers = [];
  String urlBasic = '', vendedorId = '';
  bool isLoading = true, flagClear = false;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
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
                  builder: (context) => SellerMonitorPage(),
                ),
              );
        },
      child: Scaffold(
                drawer: CustomDrawer(),
                body: Column(
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
                            SearchBarDefault(
                              flagClear: flagClear,
                              controller: searchController,
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
                              suffixIcon: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (flagClear == true)
                                    IconButton(
                                      onPressed: () async {
                                        searchController.clear();
                                        await fetchdataCustomers('');
                                      },
                                      icon: Icon(Icons.backspace_rounded),
                                      color: Style.errorColor,
                                    ),
                                  // IconButton(
                                  //   onPressed: widget.onPressedSuffix,
                                  //   icon: Icon(Icons.filter_alt_rounded),
                                  //   color: Style.secondaryColor,
                                  //   iconSize: Style.height_25(context),
                                  // )
                                ],
                              ),
                              onPressedPrefix: () async {
                                await fetchdataCustomers(searchController.text);
                              },
                              onSubmited: (value) async {
                                await fetchdataCustomers(searchController.text);
                              },
                            )
                          ],
                        )),
                    SizedBox(
                      height: Style.height_10(context),
                    ),
                    Expanded(
                        // height: Style.height_400(context),
                        child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: customers.length,
                      itemBuilder: (context, index) {
                        return CardInteractiveOfList(
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
                                      text: customers[index].nome.toString(),
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
                                      text: customers[index].codigo.toString(),
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
                                      text:
                                          '${currencyFormatDefault.format(customers[index].valorcredito)}',
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
                                      customers[index].defaulters == 0
                                          ? Icons.price_check_outlined
                                          : Icons.money_off_rounded,
                                      color: customers[index].defaulters == 0
                                          ? Style.sucefullColor
                                          : Style.errorColor,
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
                                builder: (context) => CustomerInformations(
                                  customerId: customers[index].pessoaId
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ))
                  ],
                )),
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

  Future<void> loadData() async {
    await Future.wait([_loadSavedUrlBasic(), _loadSavedSellerId()]);
    await Future.wait([fetchdataCustomers('')]);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchdataCustomers(String search) async {
    var fetchData = await DataServiceCustomers.fetchDataCustomers(
        urlBasic, vendedorId, searchController.text);
    if (fetchData != null) {
      setState(() {
        customers = fetchData.customers;
      });
    } else {
      print('ERRO!');
    }
  }
}
