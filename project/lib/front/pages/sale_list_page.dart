import 'package:flutter/material.dart';
import 'package:project/back/sales_list_functions/sale_list_data.dart';
import 'package:project/front/components/buttons/drawer_button.dart';
import 'package:project/front/components/structure/card_interactive_of_list.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/components/texts/text_card.dart';
import 'package:project/front/pages/sale_details_page.dart';
import 'package:project/front/pages/sale_monitor_page.dart';
import 'package:project/front/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaleListPage extends StatefulWidget {
  final pessoa_id;
  const SaleListPage({Key? key, this.pessoa_id});

  @override
  State<SaleListPage> createState() => _SaleListPageState();
}

class _SaleListPageState extends State<SaleListPage> {
  TextEditingController searchController = TextEditingController();
  String urlBasic = '';
  bool isLoading = true;

  List<SaleList> saleList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('AIDI - ${widget.pessoa_id}');
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
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: saleList.length,
                      itemBuilder: (context, index) {
                        return CardInteractiveOfList(
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
                                      text: saleList[index].numeromovimento,
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
                                        text: (saleList[index].datahora)
                                            .toString(),
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
                                      text:
                                          saleList[index].nomecondicaopagamento,
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
                                      text:
                                          saleList[index].flagvendaservico == 1
                                              ? 'Sim'
                                              : 'Não',
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
                                      text: (saleList[index].margem).toString(),
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
                                      text: (saleList[index].valortotal)
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
                                      text: saleList[index].pessoa_nome,
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
                        );
                      }),
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

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
  }

  Future<void> fetchDataSaleList() async {
    List<SaleList>? fetchedData =
        await DataServiceSaleList.fetchDataSaleList(widget.pessoa_id, urlBasic);
    if (fetchedData != null) {
      setState(() {
        saleList = fetchedData;
      });
    }
  }

  Future<void> loadData() async {
    await Future.wait([_loadSavedUrlBasic()]);
    await Future.wait([fetchDataSaleList()]);
    setState(() {
      isLoading = false;
    });
  }
}
