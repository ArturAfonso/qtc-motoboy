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
  HomeController controller = HomeController();

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
              key: controller.editFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Quantos KM seu veículo faz por litro de combustível?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
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
                    inputType: TextInputType.number,
                    customTextController: controller.editqtdkmPorLitro,
                    validator: Validatorless.required('campo obrigatório'),
                  ),

                  //VALOR ATUAL DA GASOLINA------------------------------------------------------------------------------------------
                  //
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Text(
                      "Qual o valor do combustível na sua região atualmente?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 13),
                      child: Text(
                        "R\$",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    onSubmitted: (p0) {},
                    inputFormatters: [
                      controller.currencyFormatter,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    customTextController: controller.editvalorAtualGasolina,
                    inputType: TextInputType.number,
                    validator: Validatorless.required('campo obrigatório'),
                  ),

//====================================================================================================

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
                  CustomTextField(
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 13),
                      child: Text(
                        "%",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    onSubmitted: (p0) {},
                    inputFormatters: [
                      controller.currencyFormatterKm,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    customTextController: controller.editpercentualDeLucro,
                    inputType: TextInputType.number,
                  ),
                  //-------------------------------------------------------------------------

                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: CustomTextButton(
                        buttonFunction: () {
                          controller.updateUserPreferences();
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
