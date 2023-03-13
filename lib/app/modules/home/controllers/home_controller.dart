import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtc_motoboy/app/data/utility.dart';

import '../../../data/models/user_model.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  late User userLogado;
  //para preenchimento do historico de corridas
  GetStorage storage = GetStorage('storage');
  final editFormKey = GlobalKey<FormState>();
  final homeFormKey = GlobalKey<FormState>();
  RxBool loading = false.obs;
  RxBool imprimir = false.obs;
  //OnboardingController cOnboarding = Get.find();
  ScrollController? optionsScrollViewController = ScrollController();
  final CurrencyTextInputFormatter currencyFormatter = CurrencyTextInputFormatter(locale: 'pt_BR', symbol: "");
  final CurrencyTextInputFormatter currencyFormatterKm =
      CurrencyTextInputFormatter(locale: 'pt_BR', symbol: "", decimalDigits: 1);
  RxBool corridaConcluida = false.obs;

//TextEditing controllers HOME
  TextEditingController editvalorAtualGasolina = TextEditingController();
  TextEditingController editdistanciaCorridaKm = TextEditingController();
  TextEditingController editqtdkmPorLitro = TextEditingController();

  TextEditingController editpercentualDeLucro = TextEditingController();

  //TextEditing controllers HOME
  TextEditingController homevalorAtualGasolina = TextEditingController();
  TextEditingController homedistanciaCorridaKm = TextEditingController();
  TextEditingController homeqtdkmPorLitro = TextEditingController();

  TextEditingController homepercentualDeLucro = TextEditingController();

  TextEditingController homecustosDaCorridaController = TextEditingController();
  TextEditingController homeValorSugeridoController = TextEditingController();

  double diferencaLucroValor = 0.0;

//------------------------------

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  void setUserLogado() {
    var verify = storage.read("usuario");
    if (verify == null) {
      Get.offAllNamed(Routes.ONBOARDING);
    } else {
      if (verify.runtimeType == User) {
        userLogado = verify;
      } else {
        userLogado = User.fromJson(verify);
        Get.put(HomeController());
      }
    }
  }

  void preencheCamposHome() {
    setUserLogado();
    if (userLogado.custos!.precoCombustivel != null) {
      homevalorAtualGasolina.text = userLogado.custos!.precoCombustivel!;
    }
    if (userLogado.veiculo!.qtdkmPorLitro != null) {
      homeqtdkmPorLitro.text = userLogado.veiculo!.qtdkmPorLitro!;
    }
    if (userLogado.percentualLucro != null) {
      homepercentualDeLucro.text = userLogado.percentualLucro!;
    }
  }

  void preencherEditarInfo() {
    setUserLogado();
    if (userLogado.custos!.precoCombustivel != null) {
      editvalorAtualGasolina.text = userLogado.custos!.precoCombustivel!;
    }
    if (userLogado.veiculo!.qtdkmPorLitro != null) {
      editqtdkmPorLitro.text = userLogado.veiculo!.qtdkmPorLitro!;
    }
    if (userLogado.percentualLucro != null) {
      editpercentualDeLucro.text = userLogado.percentualLucro!;
    }
  }

  void calculaCustosCorrida() {
    //(preçoGasolina * quantosKmPorLitroveiculoFAz) / distanciaDaCorrida
    double valorGasolina, qtdKmPorLitroVeicFaz, distanciaCorrida;
    //
    valorGasolina = Utility().convertToDouble(homevalorAtualGasolina.text);
    qtdKmPorLitroVeicFaz = Utility().convertToDouble(homeqtdkmPorLitro.text);
    distanciaCorrida = Utility().convertToDouble(homedistanciaCorridaKm.text);

    homecustosDaCorridaController.text =
        calcularValorGasto(distanciaCorrida, qtdKmPorLitroVeicFaz, valorGasolina).toStringAsFixed(2);

    if (homepercentualDeLucro.text.isNotEmpty) {
      double percentLucro = Utility().convertToDouble(homepercentualDeLucro.text);
      if (percentLucro > 0.0) {
        homeValorSugeridoController.text =
            (acrescentarPorcentagem(double.parse(homecustosDaCorridaController.text), percentLucro)).toStringAsFixed(2);

        diferencaLucroValor = calculaDiferenca(
            double.parse(homecustosDaCorridaController.text), double.parse(homeValorSugeridoController.text));
        // double.parse(homecustosDaCorridaController.text) - double.parse(homeValorSugeridoController.text);
      } else {
        diferencaLucroValor = calculaDiferenca(
            double.parse(homecustosDaCorridaController.text), double.parse(homeValorSugeridoController.text));
      }
    } else {
      double percentLucro = 0.0;
      homeValorSugeridoController.text =
          (acrescentarPorcentagem(double.parse(homecustosDaCorridaController.text), percentLucro)).toStringAsFixed(2);
      diferencaLucroValor = calculaDiferenca(
          double.parse(homecustosDaCorridaController.text), double.parse(homeValorSugeridoController.text));
    }
  }

  void updateUserPreferences() {
    if (editFormKey.currentState!.validate()) {
      userLogado.percentualLucro = editpercentualDeLucro.text;
      userLogado.custos!.precoCombustivel = editvalorAtualGasolina.text;
      userLogado.veiculo!.qtdkmPorLitro = editqtdkmPorLitro.text;

      storage.write('usuario', userLogado);
      Get.offNamed(Routes.HOME);
    }
  }
}

double calcularValorGasto(double distancia, double consumoMedio, double precoCombustivel) {
  double consumoTotal = distancia / consumoMedio;
  double valorTotal = consumoTotal * precoCombustivel;
  return valorTotal;
}

double acrescentarPorcentagem(double valor, double porcentagem) {
  double valorAcrescentado = (valor * porcentagem) / 100;
  double valorFinal = valor + valorAcrescentado;
  return valorFinal;
}

double calculaDiferenca(double custo, double valor) {
  double diferenca;
  if (custo == valor) {
    diferenca = 0.0;
    return diferenca;
  } else if (custo < valor) {
    diferenca = valor - custo;
    return diferenca;
  } else {
    diferenca = custo - valor;
    return diferenca;
  }
}






/* custo corrida(parcial) : (preçoGasolina * quantosKmPorLitroveiculoFAz) / distanciaDaCorrida

Custo de revisao por corrida: (valorRevisao / quantosKmFazREvisao) * distanciaDaCorrida

Custos com oleo por corrida: (valorTrocaDeOleo / comQuantosKmTrocaOleo) * distanciaDaCorrida


Custo Total : custo corrida(parcial) + Custo de revisao por corrida + Custos com oleo por corrida

preçoCobrado: escolhido pelo entregador

LUCRO: precoCobrado - Custo Total */