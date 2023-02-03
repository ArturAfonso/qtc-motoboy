import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtc_motoboy/app/data/models/custos.dart';
import 'package:qtc_motoboy/app/data/models/veiculo.dart';
import 'package:qtc_motoboy/app/data/utility.dart';
import 'package:qtc_motoboy/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:qtc_motoboy/app/routes/app_pages.dart';

class HomeController extends GetxController {
  OnboardingController cOnboarding = Get.find();
  ScrollController? optionsScrollViewController = ScrollController();

  final CurrencyTextInputFormatter currencyFormatter = CurrencyTextInputFormatter(locale: 'pt_BR', symbol: "");

  //home
  final homeCorridaGlobalKey = GlobalKey<FormState>();
  TextEditingController homevalorAtualGasolina = TextEditingController();
  TextEditingController homedistanciaCorridaKm = TextEditingController();
  TextEditingController homevalorInformadoMotoboy = TextEditingController();

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

  RxBool corridaConcluida = false.obs;

//para preenchimento do historico de corridas
  GetStorage storage = GetStorage('storage');
  Veiculo veiculo = Veiculo();
  Custos custos = Custos();
//------------------------------
  updateModels() {
    if (storage.read('veiculo') == null || storage.read('custos') == null) {
    } else {
      var mapa = storage.read("veiculo");

      if (mapa.runtimeType == Veiculo) {
        veiculo = mapa;
      } else {
        veiculo = Veiculo.fromJson(mapa);
      }

      var custosmapa = storage.read("custos");
      if (custosmapa.runtimeType == Custos) {
        custos = custosmapa;
      } else {
        custos = Custos.fromJson(custosmapa);
      }
    }
  }

  preencheCamposHome(
      {required double precoCobradoMotoboy, required double precoGasolina, required double distanciaCorridaKm}) async {
    // homevalorAtualGasolina.text = cOnboarding.custos.precoGasolina.toString();
    //homedistanciaCorridaKm.text = cOnboarding.custos.distanciaCorridaKm.toString();
    //

    homecustosDaCorridaController.text = calcularCustoELucro(
            info: 'custoTotal',
            distanciaCorridaKm: distanciaCorridaKm,
            precoCobradoMotoboy: precoCobradoMotoboy,
            precoGasolina: precoGasolina)
        .toStringAsFixed(2);
    homelucroDacorridaController.text = calcularCustoELucro(
            info: 'lucroFinal',
            distanciaCorridaKm: distanciaCorridaKm,
            precoCobradoMotoboy: precoCobradoMotoboy,
            precoGasolina: precoGasolina)
        .toStringAsFixed(2);
  }

  listenerHomeValoresCustos(
      {required String precoCobradoMotoboy, required String precoGasolina, required String distanciaCorridaKm}) {
    /*  if (value != null || value.isNotEmpty || value != "") {
      cOnboarding.custos.precoGasolina = Utility().convertToDouble(value);
      cOnboarding.storage.write("custos", cOnboarding.custos);
      preencheCamposHome();
    } */
    cOnboarding.custos.valorInformadoMotoboy = Utility().convertToDouble(precoCobradoMotoboy);
    cOnboarding.custos.precoGasolina = Utility().convertToDouble(precoGasolina);
    cOnboarding.custos.distanciaCorridaKm = Utility().convertToDouble(distanciaCorridaKm);
    cOnboarding.storage.write("custos", cOnboarding.custos);
    preencheCamposHome(
        precoCobradoMotoboy: cOnboarding.custos.valorInformadoMotoboy!,
        precoGasolina: cOnboarding.custos.precoGasolina!,
        distanciaCorridaKm: cOnboarding.custos.distanciaCorridaKm!);
  }

  double calcularCustoELucro(
      {String? info,
      required double precoCobradoMotoboy,
      required double precoGasolina,
      required double distanciaCorridaKm}) {
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
    if (custoTotal != 0) {
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

      /*  print("===========pagina 2 ================");

      print("valorAtualGasolina.text ${editvalorAtualGasolina.text}");
      cOnboarding.custos.precoGasolina = Utility().convertToDouble(editvalorAtualGasolina.text);
 */
      /*   print("distanciaCorridaKm.text ${editdistanciaCorridaKm.text}");
      cOnboarding.custos.distanciaCorridaKm = Utility().convertToDouble(editdistanciaCorridaKm.text); */

      /*  print("valorInformadoMotoboy.text ${editvalorInformadoMotoboy.text}");
      cOnboarding.custos.valorInformadoMotoboy = Utility().convertToDouble(editvalorInformadoMotoboy.text); */

      print('=====Updated veiculo=====');
      cOnboarding.storage.write("veiculo", cOnboarding.veiculo);
      //cOnboarding.storage.write("custos", cOnboarding.custos);

      //preencheCamposHome();
      Get.offAndToNamed(Routes.HOME);
    }
  }

  gerarComprovante() {
    if (homeCorridaGlobalKey.currentState!.validate()) {}
  }
}







/* custo corrida(parcial) : (preçoGasolina * quantosKmPorLitroveiculoFAz) / distanciaDaCorrida

Custo de revisao por corrida: (valorRevisao / quantosKmFazREvisao) * distanciaDaCorrida

Custos com oleo por corrida: (valorTrocaDeOleo / comQuantosKmTrocaOleo) * distanciaDaCorrida


Custo Total : custo corrida(parcial) + Custo de revisao por corrida + Custos com oleo por corrida

preçoCobrado: escolhido pelo entregador

LUCRO: precoCobrado - Custo Total */