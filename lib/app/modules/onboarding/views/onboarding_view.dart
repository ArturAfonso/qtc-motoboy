import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:qtc_motoboy/app/data/widgets/custom_text_button.dart';
import 'package:qtc_motoboy/app/data/widgets/custom_text_field.dart';
import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';
import 'package:validatorless/validatorless.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final OnboardingController controller = OnboardingController();
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(String assetName, {double width = 350, double? height}) {
    return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Image.asset(
            'assets/$assetName',
            width: width,
            height: height,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.symmetric(horizontal: 15),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 70),
    );

    return IntroductionScreen(
      key: introKey,
      onChange: (value) {
        setState(() {});
      },
      globalBackgroundColor: Colors.white,
      globalHeader: const Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, right: 16, bottom: 20),
            child: Text(
              "Bem vindo",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                    text: "O ",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(text: "QTC Motoboy ", style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(
                          text:
                              " é um aplicativo de gestão de entregas, com ele você irá inserir alguns dados de consumo do seu veiculo e trajeto da corrida, iremos lhe mostrar o custo total e sugerir um valor a ser cobrado na entrega.")
                    ]),
              )
            ],
          ),
          image: _buildImage('bitmap.png'),
          decoration: pageDecoration,
        ),

//================================================================================
//================================================================================
        PageViewModel(
            title: "",
            //body: "",
            //image: _buildImage('intro2.png'),
            decoration: pageDecoration,
            bodyWidget: Form(
              key: controller.onboardingFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0, bottom: 10),
                    child: Text(
                      "Preencha as informações abaixo para começar a calcular suas corridas corretamente",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "Quantos KM seu veículo faz por litro de combustível?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    inputFormatters: [controller.currencyFormatterKm, LengthLimitingTextInputFormatter(6)],
                    inputType: TextInputType.number,
                    customTextController: controller.qtdkmPorLitro,
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 13),
                      child: Text(
                        "Km",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    /*  icon: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8, right: 2),
                      child: Text(
                        "Km",
                        style: TextStyle(fontSize: 20, color: QTCsettings().textColorSecondaryLight),
                      ),
                    ), */
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      "Qual o valor do combustível na sua região atualmente?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    inputFormatters: [
                      controller.currencyFormatter,
                    ],
                    customTextController: controller.precoGasolina,
                    inputType: TextInputType.number,
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 13),
                      child: Text(
                        "R\$",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      "Quer estabelecer um percentual de lucro fixo?",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  CustomTextField(
                    onChanged: (s) {
                      debugPrint(controller.percentualLucroFixo.text.length.toString());
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 12.0, top: 13),
                      child: Text(
                        "%",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    inputFormatters: [controller.currencyFormatterKm, LengthLimitingTextInputFormatter(6)],
                    customTextController: controller.percentualLucroFixo,
                    inputType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Obx(() => CustomTextButton(
                        buttonFunction: controller.loading.value != true
                            ? () {
                                controller.loading.value = true;
                                controller.validarCamposOnboarding();
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
                ],
              ),
            )),
      ],
      onDone: () {
        controller.loading.value != true
            ? () {
                controller.loading.value = true;
                controller.validarCamposOnboarding();
              }
            : () {};
      },
      canProgress: (page) {
        int currentPage = page.round();
        if (currentPage == 1 && controller.qtdkmPorLitro.text.isEmpty) {
          return false;
        } else if (currentPage == 1 && controller.precoGasolina.text.isEmpty) {
          return false;
        } else {
          return true;
        }
      },
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: Icon(
        Icons.keyboard_double_arrow_left,
        color: QTCsettings().colorPrimaryLight,
      ),
      skip: const Text('Ignorar', style: TextStyle(fontWeight: FontWeight.w600)),
      next: Icon(
        Icons.keyboard_double_arrow_right,
        color: QTCsettings().colorPrimaryLight,
      ),
      done: Icon(
        Icons.keyboard_double_arrow_right,
        color: QTCsettings().colorPrimaryLight,
      ),
      showDoneButton: true,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: DotsDecorator(
          size: const Size(30.0, 20.0),
          color: QTCsettings().textColorPrimaryDark,
          activeSize: const Size(30.0, 20.0),
          activeColor: QTCsettings().colorPrimaryLight,
          shape: const CircleBorder(side: BorderSide(color: Colors.black))),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
