import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtc_motoboy/app/data/models/corrida_model.dart';
import 'package:qtc_motoboy/app/data/models/custos.dart';
import 'package:qtc_motoboy/app/data/models/veiculo.dart';
import 'package:qtc_motoboy/app/data/utility.dart';
import 'package:qtc_motoboy/app/modules/corridas/controllers/corridas_controller.dart';
import 'package:qtc_motoboy/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:qtc_motoboy/app/routes/app_pages.dart';

class HomeController extends GetxController {
  RxBool loading = false.obs;
  RxBool imprimir = false.obs;
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

  limparCamposHome() {
    homevalorInformadoMotoboy.clear();
    homevalorAtualGasolina.clear();
    homedistanciaCorridaKm.clear();
    homecustosDaCorridaController.clear();
    homelucroDacorridaController.clear();
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

    editkmPorLitro.text = Utility().removeZeros(cOnboarding.veiculo.kmPorLitro!);
    editvalorMedioRevisao.text = Utility().removeZeros(cOnboarding.veiculo.valorMedioRevisao!);
    editkmRevisaoMedia.text = Utility().removeZeros(cOnboarding.veiculo.kmMedioRevisao!);
    editvalorTrocaDeOleo.text = Utility().removeZeros(cOnboarding.veiculo.valorTrocaDeOleo!);
    editkmTrocaDeOleo.text = Utility().removeZeros(cOnboarding.veiculo.kmMedioTrocaDeOleo!);

    /*  editvalorAtualGasolina.text = Utility().removeZeros(cOnboarding.custos.precoGasolina!);
    editdistanciaCorridaKm.text = Utility().removeZeros(cOnboarding.custos.distanciaCorridaKm!);
    editvalorInformadoMotoboy.text = Utility().removeZeros(cOnboarding.custos.valorInformadoMotoboy!); */

    debugPrint("editar preenchido");
  }

  updateEditVeiCust() {
    if (editVeicGlobalKey.currentState!.validate()) {
      cOnboarding.storage.erase();
      cOnboarding.veiculo.kmPorLitro = Utility().convertToDouble(editkmPorLitro.text);

      debugPrint("valorMedioRevisao.text ${editvalorMedioRevisao.text}");
      cOnboarding.veiculo.valorMedioRevisao = Utility().convertToDouble(editvalorMedioRevisao.text);

      cOnboarding.veiculo.kmMedioRevisao = Utility().convertToDouble(editkmRevisaoMedia.text);

      cOnboarding.veiculo.valorTrocaDeOleo = Utility().convertToDouble(editvalorTrocaDeOleo.text);

      cOnboarding.veiculo.kmMedioTrocaDeOleo = Utility().convertToDouble(editkmTrocaDeOleo.text);

      debugPrint('=====Updated veiculo=====');
      cOnboarding.storage.write("veiculo", cOnboarding.veiculo);

      Get.offAndToNamed(Routes.HOME);
    }
  }

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  gerarCorrida() {
    loading.value = true;
    try {
      if (homeCorridaGlobalKey.currentState!.validate()) {
        updateModels();
        Corrida newCorrida = Corrida(
            idCorrida: idGenerator(),
            dataDacorrida: DateTime.now().toString(),
            precoDaGasolinaNoDia: Utility().convertToDouble(homevalorAtualGasolina.text),
            distanciaDaCorridaKm: Utility().convertToDouble(homedistanciaCorridaKm.text),
            precoCobradoPeloMotoboyNoDia: Utility().convertToDouble(homevalorInformadoMotoboy.text),
            kmPorLitroVeiculoNoDia: veiculo.kmPorLitro,
            valorMedioRevisaoVeiculoNoDia: veiculo.valorMedioRevisao,
            kmMedioRevisaoVeiculoNoDia: veiculo.valorMedioRevisao,
            valorTrocaDeOleoNoDia: veiculo.valorTrocaDeOleo,
            kmMedioTrocaDeOleoNoDia: veiculo.kmMedioTrocaDeOleo);
        CorridasController cCorridas = Get.find();
        //cCorridas.listCorridas.clear();

        cCorridas.loadListCorridas();

        cCorridas.listCorridas.add(newCorrida);

        // storage.remove("corridas");
        List<dynamic> teste = [];
        for (var element in cCorridas.listCorridas) {
          teste.add(element.toJson());
        }
        print(teste.runtimeType.toString());
        print(teste.toString());
        storage.write("corridas", teste);
        update();

        loading.value = false;
        imprimir.value = true;
        return newCorrida;
      }
    } catch (e) {
      loading.value = false;
    }
  }
}







/* custo corrida(parcial) : (preçoGasolina * quantosKmPorLitroveiculoFAz) / distanciaDaCorrida

Custo de revisao por corrida: (valorRevisao / quantosKmFazREvisao) * distanciaDaCorrida

Custos com oleo por corrida: (valorTrocaDeOleo / comQuantosKmTrocaOleo) * distanciaDaCorrida


Custo Total : custo corrida(parcial) + Custo de revisao por corrida + Custos com oleo por corrida

preçoCobrado: escolhido pelo entregador

LUCRO: precoCobrado - Custo Total */