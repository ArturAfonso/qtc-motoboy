import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motplan/app/data/utility.dart';
import 'package:motplan/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:motplan/app/routes/app_pages.dart';

class HomeController extends GetxController {
  OnboardingController cOnboarding = Get.find();
  ScrollController? optionsScrollViewController = ScrollController();

  final CurrencyTextInputFormatter currencyFormatter = CurrencyTextInputFormatter(locale: 'pt_BR', symbol: "");

  //home
  TextEditingController homevalorAtualGasolina = TextEditingController();
  TextEditingController homedistanciaCorridaKm = TextEditingController();

  TextEditingController homecustosDaCorridaController = TextEditingController();
  TextEditingController homelucroDacorridaController = TextEditingController();

  //edit veic
  final editVeicGlobalKey = GlobalKey<FormState>();
  TextEditingController editkmPorLitro = TextEditingController();
  TextEditingController editvalorMedioRevisao = TextEditingController();
  TextEditingController editkmRevisaoMedia = TextEditingController();
  TextEditingController editvalorTrocaDeOleo = TextEditingController();
  TextEditingController editkmTrocaDeOleo = TextEditingController();

  TextEditingController editvalorAtualGasolina = TextEditingController();
  TextEditingController editdistanciaCorridaKm = TextEditingController();
  TextEditingController editvalorInformadoMotoboy = TextEditingController();

  preencheCamposHome() async {
    homevalorAtualGasolina.text = cOnboarding.custos.precoGasolina.toString();
    homedistanciaCorridaKm.text = cOnboarding.custos.distanciaCorridaKm.toString();
    //

    homecustosDaCorridaController.text = calcularCustoELucro(info: 'custoCorridaParcial').toStringAsFixed(2);
    homelucroDacorridaController.text = calcularCustoELucro(info: 'lucroFinal').toStringAsFixed(2);
  }

  listenerHomeGasolina(String value) {
    cOnboarding.custos.precoGasolina = Utility().convertToDouble(value);
    cOnboarding.storage.write("custos", cOnboarding.custos);
    preencheCamposHome();
  }

  listenerHomeDistanciaKm(String value) {
    cOnboarding.custos.distanciaCorridaKm = Utility().convertToDouble(value);
    cOnboarding.storage.write("custos", cOnboarding.custos);
    preencheCamposHome();
  }

  double calcularCustoELucro({String? info, double? precoCobradoMotoboy}) {
    cOnboarding.preencheModelVeiculoCustos();
    double result = 0;
    double custoCorridaParcial = 0,
        custoRevisaoPorCorrida = 0,
        custoComOleoPorCorrida = 0,
        custoTotal = 0,
        lucroFinal = 0;

    //custo corrida(parcial) : (preçoGasolina * quantosKmPorLitroveiculoFAz) / distanciaDaCorrida
    custoCorridaParcial =
        (cOnboarding.custos.precoGasolina! * cOnboarding.veiculo.kmPorLitro!) / cOnboarding.custos.distanciaCorridaKm!;

    //Custo de revisao por corrida: (valorRevisao / quantosKmFazREvisao) * distanciaDaCorrida
    custoRevisaoPorCorrida = (cOnboarding.veiculo.valorMedioRevisao! / cOnboarding.veiculo.kmMedioRevisao!) *
        cOnboarding.custos.distanciaCorridaKm!;

    // Custos com oleo por corrida: (valorTrocaDeOleo / comQuantosKmTrocaOleo) * distanciaDaCorrida
    custoComOleoPorCorrida = (cOnboarding.veiculo.valorTrocaDeOleo! / cOnboarding.veiculo.kmMedioTrocaDeOleo!) *
        cOnboarding.custos.distanciaCorridaKm!;

    //Custo Total : custo corrida(parcial) + Custo de revisao por corrida + Custos com oleo por corrida
    custoTotal = custoCorridaParcial + custoRevisaoPorCorrida + custoComOleoPorCorrida;

    //LUCRO: precoCobrado - Custo Total
    if (precoCobradoMotoboy != null && custoTotal != 0) {
      lucroFinal = precoCobradoMotoboy - custoTotal;
    } else {
      lucroFinal = cOnboarding.custos.valorInformadoMotoboy! - custoTotal;
    }

    if (info != null) {
      switch (info) {
        case "custoCorridaParcial":
          result = custoCorridaParcial;
          break;
        case "custoRevisaoPorCorrida":
          result = custoRevisaoPorCorrida;
          break;
        case "custoComOleoPorCorrida":
          result = custoComOleoPorCorrida;
          break;
        case "custoTotal":
          result = custoTotal;
          break;
        case "lucroFinal":
          result = lucroFinal;
          break;
      }
    }
    return result;
  }

  preencherEditarInfo() {
    cOnboarding.preencheModelVeiculoCustos();

    editkmPorLitro.text = cOnboarding.veiculo.kmPorLitro.toString();
    editvalorMedioRevisao.text = cOnboarding.veiculo.valorMedioRevisao.toString();
    editkmRevisaoMedia.text = cOnboarding.veiculo.kmMedioRevisao.toString();
    editvalorTrocaDeOleo.text = cOnboarding.veiculo.valorTrocaDeOleo.toString();
    editkmTrocaDeOleo.text = cOnboarding.veiculo.kmMedioTrocaDeOleo.toString();

    editvalorAtualGasolina.text = cOnboarding.custos.precoGasolina.toString();
    editdistanciaCorridaKm.text = cOnboarding.custos.distanciaCorridaKm.toString();
    editvalorInformadoMotoboy.text = cOnboarding.custos.valorInformadoMotoboy.toString();

    print("editar preenchido");
  }

  updateEditVeiCust() {
    if (editVeicGlobalKey.currentState!.validate()) {
      cOnboarding.storage.erase();
      cOnboarding.veiculo.kmPorLitro = Utility().convertToDouble(editkmPorLitro.text);
      print(cOnboarding.veiculo.kmPorLitro);

      print("valorMedioRevisao.text ${editvalorMedioRevisao.text}");
      cOnboarding.veiculo.valorMedioRevisao = Utility().convertToDouble(editvalorMedioRevisao.text);
      print(cOnboarding.veiculo.valorMedioRevisao);

      print("kmRevisaoMedia.text ${editkmRevisaoMedia.text}");
      cOnboarding.veiculo.kmMedioRevisao = Utility().convertToDouble(editkmRevisaoMedia.text);

      print("valorTrocaDeOleo.text ${editvalorTrocaDeOleo.text}");
      cOnboarding.veiculo.valorTrocaDeOleo = Utility().convertToDouble(editvalorTrocaDeOleo.text);

      print("kmTrocaDeOleo.text ${editkmTrocaDeOleo.text}");
      cOnboarding.veiculo.kmMedioTrocaDeOleo = Utility().convertToDouble(editkmTrocaDeOleo.text);

      print("===========pagina 2 ================");

      print("valorAtualGasolina.text ${editvalorAtualGasolina.text}");
      cOnboarding.custos.precoGasolina = Utility().convertToDouble(editvalorAtualGasolina.text);

      print("distanciaCorridaKm.text ${editdistanciaCorridaKm.text}");
      cOnboarding.custos.distanciaCorridaKm = Utility().convertToDouble(editdistanciaCorridaKm.text);

      print("valorInformadoMotoboy.text ${editvalorInformadoMotoboy.text}");
      cOnboarding.custos.valorInformadoMotoboy = Utility().convertToDouble(editvalorInformadoMotoboy.text);

      print('=====Updated veiculo=====');
      cOnboarding.storage.write("veiculo", cOnboarding.veiculo);
      cOnboarding.storage.write("custos", cOnboarding.custos);

      preencheCamposHome();
      Get.offAndToNamed(Routes.HOME);
    }
  }
}







/* custo corrida(parcial) : (preçoGasolina * quantosKmPorLitroveiculoFAz) / distanciaDaCorrida

Custo de revisao por corrida: (valorRevisao / quantosKmFazREvisao) * distanciaDaCorrida

Custos com oleo por corrida: (valorTrocaDeOleo / comQuantosKmTrocaOleo) * distanciaDaCorrida


Custo Total : custo corrida(parcial) + Custo de revisao por corrida + Custos com oleo por corrida

preçoCobrado: escolhido pelo entregador

LUCRO: precoCobrado - Custo Total */