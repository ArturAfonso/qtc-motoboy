import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:qtc_motoboy/app/data/widgets/customTextField.dart';
import 'package:qtc_motoboy/app/routes/app_pages.dart';
import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';
import 'package:validatorless/validatorless.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = HomeController();

  @override
  void initState() {
    controller.preencheCamposHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.preencheCamposHome();
    return Scaffold(
        endDrawer: Drawer(
          width: Get.size.width,
          child: SafeArea(
            child: NestedScrollView(
              controller: controller.optionsScrollViewController,
              physics: const ClampingScrollPhysics(),
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    title: Text(
                      "Menu caixa",
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w700, color: QTCsettings().textColorPrimaryLight),
                    ),
                    centerTitle: true,
                    //backgroundColor: MOTsettings().colorPrimaryLight,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: IconButton(
                            onPressed: () {
                              Scaffold.of(context).closeEndDrawer();
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Icon(
                                Icons.close,
                                size: 30,
                                color: QTCsettings().colorPrimaryLight,
                              ),
                            )),
                      )
                    ],
                  ),
                ];
              },
              body: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                const Icon(Icons.local_shipping_outlined),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "Ver todas as suas corridas",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: QTCsettings().textColorPrimaryLight,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: InkWell(
                            onLongPress: () {
                              controller.cOnboarding.storage.erase();
                            },
                            onTap: () {
                              // controller.cOnboarding.preencheDadosVeiculo();
                              //Get.toNamed(Routes.ONBOARDING, arguments: {"alterarDadosVeiculo": true});
                              Get.toNamed(Routes.EDIT_INFO_VEIC);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.edit),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "Alterar informações sobre seu veículo",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: QTCsettings().textColorPrimaryLight,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    //height: 100,
                    width: Get.size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Icon(Icons.error_outline),
                                  ),
                                  Text(
                                    "Sobre",
                                    style: TextStyle(
                                        color: QTCsettings().textColorPrimaryLight,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Text(
                                "QTC motoboy 1.0.0+1",
                                style: TextStyle(
                                    color: QTCsettings().textColorPrimaryLight,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Text("Desenvolvido por ",
                                      style: TextStyle(
                                          color: QTCsettings().textColorPrimaryLight,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)),
                                  Text("W3Start",
                                      style: TextStyle(
                                          color: QTCsettings().textColorPrimaryLight,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16)),
                                ],
                              ),
                              Text("sac@w3start.com.br",
                                  style: TextStyle(
                                      color: QTCsettings().textColorPrimaryLight,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
                            width: Get.size.width,
                            color: QTCsettings().colorPrimaryLight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.payments,
                                    color: Colors.white,
                                  ),
                                  Text("Deseja contribuir com a manutenção deste aplicativo?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)),
                                  Text("chave pix sac@empresa.com.br",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            Builder(builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: QTCsettings().colorPrimaryLight,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              );
            }),
          ],
          backgroundColor: Colors.white,
          title: Text(
            'QTC Motoboy',
            style: TextStyle(color: QTCsettings().textColorPrimaryLight, fontWeight: FontWeight.w800, fontSize: 22),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Preencha as informações da viagem e custo e lucro serão calculados',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: QTCsettings().textColorPrimaryLight, fontWeight: FontWeight.w800, fontSize: 18),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 55, bottom: 10.0),
                  child: Text(
                    "Valor atual do litro da gasolina?",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                FocusScope(
                  onFocusChange: (value) {
                    if (!value) {
                      setState(() {
                        controller.listenerHomeGasolina(controller.homevalorAtualGasolina.text);
                      });
                    }
                  },
                  child: CustomTextField(
                    onSubmitted: (p0) {
                      setState(() {
                        controller.listenerHomeGasolina(p0);
                      });
                    },
                    inputFormatters: [
                      controller.currencyFormatter,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    customTextController: controller.homevalorAtualGasolina,
                    inputType: TextInputType.number,
                    label: const Text(
                      "R\$",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                ),
//-------------------------------------------------------------------------

                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5.0),
                  child: Text(
                    "Distância da corrida em KM?",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                FocusScope(
                  onFocusChange: (value) {
                    if (!value) {
                      setState(() {
                        controller.listenerHomeDistanciaKm(controller.homedistanciaCorridaKm.text);
                      });
                    }
                  },
                  child: CustomTextField(
                    onSubmitted: (p0) {
                      setState(() {
                        controller.listenerHomeDistanciaKm(p0);
                      });
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    customTextController: controller.homedistanciaCorridaKm,
                    inputType: TextInputType.number,
                    label: const Text(
                      "KM",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                ),
                //-------------------------------------------------------
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5.0),
                  child: Text(
                    "Custo total da corrida",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                CustomTextField(
                  filled: controller.homecustosDaCorridaController.text.isEmpty ? true : false,
                  fillcolor: Colors.grey.shade300,
                  readOnly: true,
                  inputFormatters: [
                    controller.currencyFormatter,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  customTextController: controller.homecustosDaCorridaController,
                  inputType: TextInputType.number,
                  label: const Text(
                    "R\$",
                  ),
                  validator: Validatorless.required('campo obrigatório'),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5.0),
                  child: Text(
                    "Lucro da corrida",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                CustomTextField(
                  textColor: controller.homelucroDacorridaController.text.contains("-")
                      ? QTCsettings().errorColor
                      : Colors.green,
                  filled: controller.homelucroDacorridaController.text.isEmpty ? true : false,
                  fillcolor: Colors.grey.shade300,
                  readOnly: true,
                  inputFormatters: [
                    controller.currencyFormatter,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  customTextController: controller.homelucroDacorridaController,
                  inputType: TextInputType.number,
                  label: const Text(
                    "R\$",
                  ),
                  validator: Validatorless.required('campo obrigatório'),
                ),
              ],
            ),
          ),
        ));
  }
}
