import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtc_motoboy/app/data/models/custos.dart';
import 'package:qtc_motoboy/app/data/models/veiculo.dart';
import 'package:qtc_motoboy/app/data/utility.dart';
import 'package:qtc_motoboy/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  RxBool loading = false.obs;
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
  // final page2 = GlobalKey<FormState>();

  String verifyStorage() {
    if (storage.read('veiculo') == null /* || storage.read('custos') == null */) {
      return AppPages.INITIAL;
    } else {
      var mapa = storage.read("veiculo");
      veiculo = Veiculo.fromJson(mapa);
      /*  var custosmapa = storage.read("custos");
      custos = Custos.fromJson(custosmapa); */

      return Routes.HOME;
    }
  }

  validarVeiculo() {
    if (page1.currentState!.validate() /*  && page2.currentState!.validate() */) {
      veiculo.kmPorLitro = Utility().convertToDouble(kmPorLitro.text);
      veiculo.valorMedioRevisao = Utility().convertToDouble(valorMedioRevisao.text);
      veiculo.kmMedioRevisao = Utility().convertToDouble(kmRevisaoMedia.text);
      veiculo.valorTrocaDeOleo = Utility().convertToDouble(valorTrocaDeOleo.text);
      veiculo.kmMedioTrocaDeOleo = Utility().convertToDouble(kmTrocaDeOleo.text);

      /*   print("===========pagina 2 ================");

      custos.precoGasolina = Utility().convertToDouble(valorAtualGasolina.text);
      custos.distanciaCorridaKm = Utility().convertToDouble(distanciaCorridaKm.text);
      custos.valorInformadoMotoboy = Utility().convertToDouble(valorInformadoMotoboy.text); */

      debugPrint('===== veiculo salvo=====');
      storage.write("veiculo", veiculo);
      //storage.write("custos", custos);
    }
    // storage.erase();
  }

  preencheModelVeiculoCustos() {
    //chamado ao abrir Editar informações
    if (storage.read('veiculo') == null /*  || storage.read('custos') == null */) {
    } else {
      var mapa = storage.read("veiculo");

      if (mapa.runtimeType == Veiculo) {
        veiculo = mapa;
      } else {
        veiculo = Veiculo.fromJson(mapa);
      }
    }

    if (storage.read('custos') == null) {
    } else {
      var custosmapa = storage.read("custos");
      if (custosmapa.runtimeType == Custos) {
        custos = custosmapa;
      } else {
        custos = Custos.fromJson(custosmapa);
      }
    }

    kmPorLitro.text = Utility().removeZeros(veiculo.kmPorLitro!);
    valorMedioRevisao.text = Utility().removeZeros(veiculo.valorMedioRevisao!);
    kmRevisaoMedia.text = Utility().removeZeros(veiculo.kmMedioRevisao!);
    valorTrocaDeOleo.text = Utility().removeZeros(veiculo.valorTrocaDeOleo!);
    kmTrocaDeOleo.text = Utility().removeZeros(veiculo.kmMedioTrocaDeOleo!);

/*     //pagina2
    valorAtualGasolina.text = custos.precoGasolina.toString();
    distanciaCorridaKm.text = custos.distanciaCorridaKm.toString();
    valorInformadoMotoboy.text = custos.valorInformadoMotoboy.toString(); */
  }
}
