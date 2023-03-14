import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qtc_motoboy/app/data/widgets/custom_text_button.dart';
import 'package:qtc_motoboy/app/data/widgets/custom_text_field.dart';
import 'package:qtc_motoboy/app/routes/app_pages.dart';
import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';
import 'package:validatorless/validatorless.dart';

import '../controllers/home_controller.dart';
import 'print_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = HomeController();
  RxBool copied = false.obs;
  //#0D6EFD

  @override
  void initState() {
    controller.preencheCamposHome();
    super.initState();
  }

  //CorridasController cCorridas = Get.find();
  @override
  Widget build(BuildContext context) {
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
                            onTap: () {
                              Get.toNamed(Routes.CORRIDAS);
                            },
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
                              controller.storage.erase();
                            },
                            onTap: () {
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const EraseDatabaseDialog();
                                  });
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.dangerous_outlined),
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  "APAGAR SUA BASE DE DADOS",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: QTCsettings().textColorPrimaryLight,
                                      fontWeight: FontWeight.bold,
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
                              child: Obx(() => InkWell(
                                    onTap: () {
                                      /*   showDialog(
                                        context: context,
                                        builder: (_) {
                                          return DonateDialog();
                                        },
                                      ); */
                                      try {
                                        Clipboard.setData(const ClipboardData(text: "pix@w3start.com.br"));
                                        copied.value = true;
                                        Future.delayed(const Duration(seconds: 2), () {
                                          copied.value = false;
                                        });
                                      } on Exception {
                                        copied.value = false;
                                      }
                                    },
                                    child: copied.value == true
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 33),
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "Pix Copiado para area de transferencia",
                                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.payments,
                                                color: Colors.white,
                                              ),
                                              Text("Deseja contribuir com a manutenção deste aplicativo?",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)),
                                              Text("chave pix: pix@w3start.com.br",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)),
                                            ],
                                          ),
                                  )),
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
                    //cCorridas.loadListCorridas();
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

        //====================================================================================================
        body: Form(
          key: controller.homeFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Preencha as informações da viagem e custo e lucro serão calculados',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: QTCsettings().textColorPrimaryLight, fontWeight: FontWeight.w800, fontSize: 18),
                  ),

                  //VALOR ATUAL DA GASOLINA------------------------------------------------------------------------------------------
                  //
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Text(
                      "Qual o valor do combustível na sua região?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  FocusScope(
                    onFocusChange: (value) {
                      if (!value) {
                        setState(() {
                          if (controller.homevalorAtualGasolina.text.isNotEmpty &&
                              controller.homevalorAtualGasolina.text != "" &&
                              controller.homeqtdkmPorLitro.text.isNotEmpty &&
                              controller.homeqtdkmPorLitro.text != "" &&
                              controller.homedistanciaCorridaKm.text.isNotEmpty &&
                              controller.homedistanciaCorridaKm.text != "") {
                            controller.calculaCustosCorrida();
                          }
                        });
                      }
                    },
                    child: CustomTextField(
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 13),
                        child: Text(
                          "R\$",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      onSubmitted: (p0) {
                        setState(() {
                          if (controller.homevalorAtualGasolina.text.isNotEmpty &&
                              controller.homevalorAtualGasolina.text != "" &&
                              controller.homeqtdkmPorLitro.text.isNotEmpty &&
                              controller.homeqtdkmPorLitro.text != "" &&
                              controller.homedistanciaCorridaKm.text.isNotEmpty &&
                              controller.homedistanciaCorridaKm.text != "") {
                            controller.calculaCustosCorrida();
                          }
                        });
                      },
                      inputFormatters: [
                        controller.currencyFormatter,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      customTextController: controller.homevalorAtualGasolina,
                      inputType: TextInputType.number,
                      validator: Validatorless.required('campo obrigatório'),
                    ),
                  ),
                  //-------------------------------------------------------------------------
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Text(
                      "Quantos KM seu veículo faz por litro de combustível?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),

                  FocusScope(
                    onFocusChange: (value) {
                      if (!value) {
                        setState(() {
                          if (controller.homevalorAtualGasolina.text.isNotEmpty &&
                              controller.homevalorAtualGasolina.text != "" &&
                              controller.homeqtdkmPorLitro.text.isNotEmpty &&
                              controller.homeqtdkmPorLitro.text != "" &&
                              controller.homedistanciaCorridaKm.text.isNotEmpty &&
                              controller.homedistanciaCorridaKm.text != "") {
                            controller.calculaCustosCorrida();
                          }
                        });
                      }
                    },
                    child: CustomTextField(
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 13),
                        child: Text(
                          "Km",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      onSubmitted: (p0) {
                        setState(() {
                          if (controller.homevalorAtualGasolina.text.isNotEmpty &&
                              controller.homevalorAtualGasolina.text != "" &&
                              controller.homeqtdkmPorLitro.text.isNotEmpty &&
                              controller.homeqtdkmPorLitro.text != "" &&
                              controller.homedistanciaCorridaKm.text.isNotEmpty &&
                              controller.homedistanciaCorridaKm.text != "") {
                            controller.calculaCustosCorrida();
                          }
                        });
                      },
                      inputFormatters: [
                        controller.currencyFormatterKm,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      customTextController: controller.homeqtdkmPorLitro,
                      inputType: TextInputType.number,
                      validator: Validatorless.required('campo obrigatório'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Row(
                      children: [
                        const Text(
                          "Distância da corrida",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "(Não sabe a distancia?)",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: HexColor("#0D6EFD"), fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FocusScope(
                    onFocusChange: (value) {
                      if (!value) {
                        setState(() {
                          if (controller.homevalorAtualGasolina.text.isNotEmpty &&
                              controller.homevalorAtualGasolina.text != "" &&
                              controller.homeqtdkmPorLitro.text.isNotEmpty &&
                              controller.homeqtdkmPorLitro.text != "" &&
                              controller.homedistanciaCorridaKm.text.isNotEmpty &&
                              controller.homedistanciaCorridaKm.text != "") {
                            controller.calculaCustosCorrida();
                          }
                        });
                      }
                    },
                    child: CustomTextField(
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 13),
                        child: Text(
                          "Km",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      inputFormatters: [
                        controller.currencyFormatterKm,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      onSubmitted: (p0) {
                        setState(() {
                          if (controller.homevalorAtualGasolina.text.isNotEmpty &&
                              controller.homevalorAtualGasolina.text != "" &&
                              controller.homeqtdkmPorLitro.text.isNotEmpty &&
                              controller.homeqtdkmPorLitro.text != "" &&
                              controller.homedistanciaCorridaKm.text.isNotEmpty &&
                              controller.homedistanciaCorridaKm.text != "") {
                            controller.calculaCustosCorrida();
                          }
                        });
                      },
                      customTextController: controller.homedistanciaCorridaKm,
                      inputType: TextInputType.number,
                      validator: Validatorless.required('campo obrigatório'),
                    ),
                  ),
                  //PERCENTUAL DE LUCRO------------------------------------------------------------------------------------------
                  //
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Text(
                      "Percentual de lucro",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  FocusScope(
                    onFocusChange: (value) {
                      if (!value) {
                        setState(() {
                          if (controller.homevalorAtualGasolina.text.isNotEmpty &&
                              controller.homevalorAtualGasolina.text != "" &&
                              controller.homeqtdkmPorLitro.text.isNotEmpty &&
                              controller.homeqtdkmPorLitro.text != "" &&
                              controller.homedistanciaCorridaKm.text.isNotEmpty &&
                              controller.homedistanciaCorridaKm.text != "") {
                            controller.calculaCustosCorrida();
                          }
                        });
                      }
                    },
                    child: CustomTextField(
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 13),
                        child: Text(
                          "%",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      onSubmitted: (p0) {
                        setState(() {
                          if (controller.homevalorAtualGasolina.text.isNotEmpty &&
                              controller.homevalorAtualGasolina.text != "" &&
                              controller.homeqtdkmPorLitro.text.isNotEmpty &&
                              controller.homeqtdkmPorLitro.text != "" &&
                              controller.homedistanciaCorridaKm.text.isNotEmpty &&
                              controller.homedistanciaCorridaKm.text != "") {
                            controller.calculaCustosCorrida();
                          }
                        });
                      },
                      inputFormatters: [
                        controller.currencyFormatterKm,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      customTextController: controller.homepercentualDeLucro,
                      inputType: TextInputType.number,
                      //validator: Validatorless.required('campo obrigatório'),
                    ),
                  ),
                  //-------------------------------------------------------------------------
                  //-------------------------------------------------------
                  Visibility(
                    visible: controller.imprimir.value != true,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5.0),
                      child: SizedBox(
                        width: Get.size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Custos da corrida",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 65,
                            ),
                            Text(
                              "Valor sugerido",
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.imprimir.value != true,
                    child: SizedBox(
                      width: Get.size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              //width: Get.size.width / 2,
                              decoration: BoxDecoration(
                                  color: QTCsettings().colorPrimaryLight,
                                  borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "R\$ ${controller.homecustosDaCorridaController.text}",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style:
                                      const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              //width: Get.size.width / 3,
                              decoration: BoxDecoration(
                                  color: controller.homeValorSugeridoController.text.contains("-")
                                      ? Colors.red
                                      : HexColor("#0D6EFD"),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "R\$ ${controller.homeValorSugeridoController.text} ",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  style:
                                      const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                                  //(R\$ ${controller.diferencaLucroValor.toStringAsFixed(2)})
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Visibility(
                    visible: controller.diferencaLucroValor != 0.0,
                    replacement: const SizedBox(
                      height: 25,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Center(
                        child: Text(
                          "Lucro: R\$ ${controller.diferencaLucroValor.toStringAsFixed(2)} ",
                          maxLines: 1,
                          style: const TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w400),
                          //(R\$ ${controller.diferencaLucroValor.toStringAsFixed(2)})
                        ),
                      ),
                    ),
                  ),
                  controller.imprimir.value == false
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Obx(() => CustomTextButton(
                              buttonFunction: controller.loading.value != true
                                  ? () async {
                                      if (controller.homevalorAtualGasolina.text.isNotEmpty &&
                                          controller.homevalorAtualGasolina.text != "" &&
                                          controller.homeqtdkmPorLitro.text.isNotEmpty &&
                                          controller.homeqtdkmPorLitro.text != "" &&
                                          controller.homedistanciaCorridaKm.text.isNotEmpty &&
                                          controller.homedistanciaCorridaKm.text != "") {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        controller.calculaCustosCorrida();
                                        setState(() {});
                                        controller.gerarCorrida();
                                      } else {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        controller.homeFormKey.currentState!.validate();
                                      }
                                    }
                                  : () {},
                              controller: controller,
                              widgetTitle: controller.loading.value != true
                                  ? Text("Concluir",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: QTCsettings().textColorPrimaryDark,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400))
                                  : const CircularProgressIndicator(
                                      color: Colors.white,
                                    ))),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: CustomTextButton(
                                  buttonFunction: () {
                                    setState(() {
                                      controller.imprimir.value = false;
                                      controller.loading.value = false;

                                      controller.preencheCamposHome();
                                    });
                                  },
                                  controller: controller,
                                  widgetTitle: Text("Nova corrida",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: QTCsettings().textColorPrimaryDark,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: CustomTextButton(
                                  buttonFunction: () {
                                    controller.imprimir.value = false;
                                    //controller.limparCamposHome();

                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return PrintDialog(corrida: controller.listCorrida.last);
                                      },
                                    );
                                  },
                                  controller: controller,
                                  widgetTitle: Text("Enviar comprovante",
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: QTCsettings().textColorPrimaryDark,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400))),
                            )
                          ],
                        ),
                ],
              ),
            ),
          ),
        ));
  }
}

class EraseDatabaseDialog extends StatelessWidget {
  const EraseDatabaseDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GetStorage storage = GetStorage('storage');
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'CUIDADO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  ),
                ),

                // Vencimento
                const Text(
                  'Você esta prestes a DELETAR todo seu historico de corridas e preferências, esta açao e irreversivel',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),

                // Botão copia e cola
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    storage.erase();
                    Get.offAndToNamed(AppPages.INITIAL);
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    size: 25,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Deletar',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
