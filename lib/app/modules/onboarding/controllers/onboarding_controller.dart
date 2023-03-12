import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtc_motoboy/app/data/models/custos_model.dart';
import 'package:qtc_motoboy/app/data/models/user_model.dart';

import '../../../data/models/veiculo_model.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  RxBool loading = false.obs;
  GetStorage storage = GetStorage('storage');
  final CurrencyTextInputFormatter currencyFormatter = CurrencyTextInputFormatter(locale: 'pt_BR', symbol: "");
  final CurrencyTextInputFormatter currencyFormatterKm =
      CurrencyTextInputFormatter(locale: 'pt_BR', symbol: "", decimalDigits: 1);

  TextEditingController qtdkmPorLitro = TextEditingController();
  TextEditingController precoGasolina = TextEditingController();
  TextEditingController percentualLucroFixo = TextEditingController();

  //pagina 1
  final onboardingFormKey = GlobalKey<FormState>();

  void validarCamposOnboarding() {
    if (onboardingFormKey.currentState!.validate()) {
      Veiculo veic = Veiculo();
      veic.qtdkmPorLitro = qtdkmPorLitro.text;
      Custos cust = Custos();
      cust.precoCombustivel = precoGasolina.text;
      User user = User();
      user.veiculo = veic;
      user.custos = cust;
      if (percentualLucroFixo.text.isNotEmpty) {
        user.percentualLucro = percentualLucroFixo.text;
      }

      storage.write('usuario', user);
      Get.offAllNamed(Routes.HOME);

      loading.value = false;
    } else {
      loading.value = false;
    }
  }
}
