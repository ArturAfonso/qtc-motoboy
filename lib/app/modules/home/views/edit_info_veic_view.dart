import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:qtc_motoboy/app/data/widgets/custom_text_button.dart';
import 'package:qtc_motoboy/app/data/widgets/custom_text_field.dart';
import 'package:qtc_motoboy/app/modules/home/controllers/home_controller.dart';
import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';
import 'package:validatorless/validatorless.dart';

class EditInfoVeicView extends StatefulWidget {
  const EditInfoVeicView({super.key});

  @override
  State<EditInfoVeicView> createState() => _EditInfoVeicViewState();
}

class _EditInfoVeicViewState extends State<EditInfoVeicView> {
  HomeController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.preencherEditarInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_sharp,
              color: QTCsettings().colorPrimaryLight,
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Editar Informações',
            style: TextStyle(color: QTCsettings().textColorPrimaryLight, fontWeight: FontWeight.w800, fontSize: 22),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
            child: Form(
              key: controller.editVeicGlobalKey,
              child: Column(
                children: [
                  /*  const Padding(
                        padding: EdgeInsets.only(top: 40.0, bottom: 80),
                        child: Text(
                          "Preencha as informações abaixo para começar a calcular suas corridas corretamente",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ), */
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Quantos KM seu veículo faz por litro de combustível?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    inputType: TextInputType.number,
                    customTextController: controller.editkmPorLitro,
                    label: const Text(
                      "KM",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      "Qual o valor médio da revisão de seu veículo?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    onChanged: (p0) {
                      debugPrint(controller.editvalorMedioRevisao.text.length.toString());
                    },
                    inputFormatters: [controller.currencyFormatter, LengthLimitingTextInputFormatter(10)],
                    customTextController: controller.editvalorMedioRevisao,
                    inputType: TextInputType.number,
                    label: const Text(
                      "R\$",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      "Quantos KM em média você faz revisão?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    customTextController: controller.editkmRevisaoMedia,
                    inputType: TextInputType.number,
                    label: const Text(
                      "KM",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      "Qual o valor médio da troca de óleo de seu veículo?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    inputFormatters: [
                      controller.currencyFormatter,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    customTextController: controller.editvalorTrocaDeOleo,
                    inputType: TextInputType.number,
                    label: const Text(
                      "R\$",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      "Com quantos KM você troca o óleo de seu veículo?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    customTextController: controller.editkmTrocaDeOleo,
                    inputType: TextInputType.number,
                    label: const Text(
                      "KM",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  /*  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Text(
                      "Valor atual do litro da gasolina?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    inputFormatters: [
                      controller.currencyFormatter,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    customTextController: controller.editvalorAtualGasolina,
                    inputType: TextInputType.number,
                    label: const Text(
                      "R\$",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5.0),
                    child: Text(
                      "Distância da corrida em KM?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    customTextController: controller.editdistanciaCorridaKm,
                    inputType: TextInputType.number,
                    label: const Text(
                      "KM",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5.0),
                    child: Text(
                      "Quanto você pretende cobrar por esta corrida?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    inputFormatters: [
                      controller.currencyFormatter,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    customTextController: controller.editvalorInformadoMotoboy,
                    inputType: TextInputType.number,
                    label: const Text(
                      "KM",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ), */
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: CustomTextButton(
                        buttonFunction: () {
                          controller.updateEditVeiCust();
                        },
                        controller: controller,
                        title: "Concluir"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
