import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:qtc_motoboy/app/data/widgets/custom_text_button.dart';
import 'package:qtc_motoboy/app/data/widgets/custom_text_field.dart';
import 'package:qtc_motoboy/app/routes/app_pages.dart';
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
    var arg = Get.arguments;
    if (arg != null) {
      if (arg['alterarDadosVeiculo'] == true) {
        controller.preencheModelVeiculoCustos();
      }
    }

    return IntroductionScreen(
      key: introKey,

      onChange: (value) {
        setState(() {});
        /*  print(value);
        if (value == 1) {
          controller.page1.currentState!.validate();
        } else if (value == 1) {
          controller.page2.currentState!.validate();
        } */
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
                              " é um aplicativo de gestão de entregas no qual o entregador consegue inserir seus custos e calcular corretamente o exato valor no qual está lucrando por entrega.")
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
              key: controller.page1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 40.0, bottom: 80),
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
                    inputFormatters: [
                      controller.currencyFormatter, /* LengthLimitingTextInputFormatter(10) */
                    ],
                    inputType: TextInputType.number,
                    customTextController: controller.kmPorLitro,
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
                      debugPrint(controller.valorMedioRevisao.text.length.toString());
                    },
                    inputFormatters: [
                      controller.currencyFormatter, /*  LengthLimitingTextInputFormatter(10) */
                    ],
                    customTextController: controller.valorMedioRevisao,
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
                      controller.currencyFormatter, /* LengthLimitingTextInputFormatter(10) */
                    ],
                    customTextController: controller.kmRevisaoMedia,
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
                      /*  LengthLimitingTextInputFormatter(10), */
                    ],
                    customTextController: controller.valorTrocaDeOleo,
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
                      controller.currencyFormatter, /*  LengthLimitingTextInputFormatter(10) */
                    ],
                    customTextController: controller.kmTrocaDeOleo,
                    inputType: TextInputType.number,
                    label: const Text(
                      "KM",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Obx(() => CustomTextButton(
                        buttonFunction: controller.loading.value != true
                            ? () {
                                controller.loading.value = true;
                                controller.validarVeiculo();
                                if (controller.page1.currentState!
                                    .validate() /*  && controller.page2.currentState!.validate() */) {
                                  Future.delayed(const Duration(seconds: 2), () {
                                    Get.offAllNamed(Routes.HOME);
                                    controller.loading.value = false;
                                  });
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
                ],
              ),
            )),
//================================================================================
//================================================================================
        /*  PageViewModel(
            title: "",
            image: _buildImage('bitmap.png', width: 300, height: 300),
            decoration: pageDecoration,
            bodyWidget: Form(
              key: controller.page2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
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
                    customTextController: controller.valorAtualGasolina,
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
                    customTextController: controller.distanciaCorridaKm,
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
                    customTextController: controller.valorInformadoMotoboy,
                    inputType: TextInputType.number,
                    label: const Text(
                      "KM",
                    ),
                    validator: Validatorless.required('campo obrigatório'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: CustomTextButton(
                        buttonFunction: () {
                          controller.validarVeiculo();
                          if (controller.page1.currentState!.validate() && controller.page2.currentState!.validate()) {
                            Future.delayed(const Duration(seconds: 2), () {
                              Get.offAllNamed(Routes.HOME);
                            });
                          }
                        },
                        controller: controller,
                        title: "Concluir"),
                  )
                ],
              ),
            )), */
      ],
      onDone: () {
        /* controller.page1.currentState!.validate();
        controller.page2.currentState!.validate(); */
        controller.validarVeiculo();
        if (controller.page1.currentState!.validate() /*  && controller.page2.currentState!.validate() */) {
          Future.delayed(const Duration(seconds: 2), () {
            Get.offAllNamed(Routes.HOME);
          });
        }
      },
      //onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      //showSkipButton: true,
      canProgress: (page) {
        int currentPage = page.round();
        if (currentPage == 1 && controller.kmPorLitro.text.isEmpty) {
          return false;
        } else if (currentPage == 1 && controller.valorMedioRevisao.text.isEmpty) {
          return false;
        } else if (currentPage == 1 && controller.kmRevisaoMedia.text.isEmpty) {
          return false;
        } else if (currentPage == 1 && controller.valorTrocaDeOleo.text.isEmpty) {
          return false;
        } else if (currentPage == 1 && controller.kmTrocaDeOleo.text.isEmpty) {
          return false;
        } /* else if (currentPage == 2 && controller.valorAtualGasolina.text.isEmpty) {
          return false;
        } else if (currentPage == 2 && controller.distanciaCorridaKm.text.isEmpty) {
          return false;
        } else if (currentPage == 2 && controller.valorInformadoMotoboy.text.isEmpty) {
          return false;
        } */
        else {
          return true;
        }
      },
      skipOrBackFlex: 0,

      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
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
          shape: const CircleBorder(side: BorderSide(color: Colors.black))
          /*  activeShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ), */
          ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
