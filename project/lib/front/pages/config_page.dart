import 'package:flutter/material.dart';
import 'package:project/back/config_functions/save_url_function.dart';
import 'package:project/front/components/buttons/action_button.dart';
import 'package:project/front/components/inputs/input.dart';
import 'package:project/front/components/structure/form_card.dart';
import 'package:project/front/components/structure/navbar.dart';
import 'package:project/front/style/style.dart';
import 'package:project/front/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  final String initialUrl;

  const ConfigPage({super.key, this.initialUrl = ''});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  TextEditingController urlController = TextEditingController();
  final SaveUrlFunction saveUrlFunction = SaveUrlFunction();

  @override
  void initState() {
    super.initState();
    urlController.text = widget.initialUrl;
  }

  Future<void> _loadSavedUrl() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrl = sharedPreferences.getString('saveUrl') ?? '';
    setState(() {
      urlController.text = savedUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    //Chamando a navbar
                    Navbar(children: [
                      //Chamando os elementos internos da navbar
                    ], text: 'Configurações'),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Chamando o container com os elementos para login
                          FormCard(
                            children: [
                              SizedBox(
                                height: Style.height_50(context),
                              ),
                              //Chamando elementos para dentro do container
                              Input(
                                type: TextInputType.text,
                                text: 'Configuração de IP',
                                obscureText: false,
                                controller: urlController,
                                // textInputAction: TextInputAction.go,
                              ),
                              SizedBox(
                                height: Style.height_50(context),
                              ),
                              Column(
                                children: [
                                  Row(
                                    //Alinhamento dos buttons
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //Chamando os button
                                      ActionButton(
                                        text: 'Salvar',
                                        onPressed: () {
                                          saveUrlFunction.saveUrlFunction(
                                              context, urlController.text);
                                        },
                                        height: Style.ActionButtonSize(context),
                                      ),
                                      SizedBox(
                                        width: Style.ButtonToButtonSpaceWidth(
                                            context),
                                      ),
                                      ActionButton(
                                        text: 'Voltar',
                                        onPressed: () async {
                                          String url = urlController.text;
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage(url: url),
                                            ),
                                          );
                                        },
                                        height: Style.ActionButtonSize(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onWillPop: () async {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginPage(url: urlController.text),
                ),
              );
              return true;
            }));
  }
}
