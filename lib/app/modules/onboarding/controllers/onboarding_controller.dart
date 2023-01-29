import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtc_motoboy/app/data/models/custos.dart';
import 'package:qtc_motoboy/app/data/models/veiculo.dart';
import 'package:qtc_motoboy/app/data/utility.dart';
import 'package:qtc_motoboy/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  //FlutterSecureStorage storage = const FlutterSecureStorage();
  GetStorage storage = GetStorage('storage');
  Veiculo veiculo = Veiculo();
  Custos custos = Custos();

  final CurrencyTextInputFormatter currencyFormatter = CurrencyTextInputFormatter(locale: 'pt_BR', symbol: "");

  //pagina 1
  TextEditingController kmPorLitro = TextEditingController();
  TextEditingController valorMedioRevisao = TextEditingController();
  TextEditingController kmRevisaoMedia = TextEditingController();
  TextEditingController valorTrocaDeOleo = TextEditingController();
  TextEditingController kmTrocaDeOleo = TextEditingController();

  //pagina 2
  TextEditingController valorAtualGasolina = TextEditingController();

  TextEditingController distanciaCorridaKm = TextEditingController();
  TextEditingController valorInformadoMotoboy = TextEditingController();

  //pagina 1
  final page1 = GlobalKey<FormState>();
  final page2 = GlobalKey<FormState>();

  String verifyStorage() {
    if (storage.read('veiculo') == null || storage.read('custos') == null) {
      return AppPages.INITIAL;
    } else {
      var mapa = storage.read("veiculo");
      veiculo = Veiculo.fromJson(mapa);
      var custosmapa = storage.read("custos");
      custos = Custos.fromJson(custosmapa);
      return Routes.HOME;
    }
  }

  validarVeiculo() {
    if (page1.currentState!.validate() && page2.currentState!.validate()) {
      print("===========pagina 1 ================");
      print("kmPorLitro.text ${kmPorLitro.text}");
      veiculo.kmPorLitro = Utility().convertToDouble(kmPorLitro.text);
      print(veiculo.kmPorLitro);

      print("valorMedioRevisao.text ${valorMedioRevisao.text}");
      veiculo.valorMedioRevisao = Utility().convertToDouble(valorMedioRevisao.text);
      print(veiculo.valorMedioRevisao);

      print("kmRevisaoMedia.text ${kmRevisaoMedia.text}");
      veiculo.kmMedioRevisao = Utility().convertToDouble(kmRevisaoMedia.text);

      print("valorTrocaDeOleo.text ${valorTrocaDeOleo.text}");
      veiculo.valorTrocaDeOleo = Utility().convertToDouble(valorTrocaDeOleo.text);

      print("kmTrocaDeOleo.text ${kmTrocaDeOleo.text}");
      veiculo.kmMedioTrocaDeOleo = Utility().convertToDouble(kmTrocaDeOleo.text);

      print("===========pagina 2 ================");

      print("valorAtualGasolina.text ${valorAtualGasolina.text}");
      custos.precoGasolina = Utility().convertToDouble(valorAtualGasolina.text);

      print("distanciaCorridaKm.text ${distanciaCorridaKm.text}");
      custos.distanciaCorridaKm = Utility().convertToDouble(distanciaCorridaKm.text);

      print("valorInformadoMotoboy.text ${valorInformadoMotoboy.text}");
      custos.valorInformadoMotoboy = Utility().convertToDouble(valorInformadoMotoboy.text);

      print('===== veiculo salvo=====');
      storage.write("veiculo", veiculo);
      storage.write("custos", custos);
      /* var teste = storage.read('veiculo');
      print(teste); */
    }
    // storage.erase();
  }

  preencheModelVeiculoCustos() {
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

    kmPorLitro.text = veiculo.kmPorLitro.toString();
    valorMedioRevisao.text = veiculo.valorMedioRevisao.toString();
    kmRevisaoMedia.text = veiculo.kmMedioRevisao.toString();
    valorTrocaDeOleo.text = veiculo.valorTrocaDeOleo.toString();
    kmTrocaDeOleo.text = veiculo.kmMedioTrocaDeOleo.toString();

    //pagina2
    valorAtualGasolina.text = custos.precoGasolina.toString();
    distanciaCorridaKm.text = custos.distanciaCorridaKm.toString();
    valorInformadoMotoboy.text = custos.valorInformadoMotoboy.toString();
  }
}
