import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtc_motoboy/app/app_settings.dart';
import 'package:qtc_motoboy/app/modules/home/controllers/home_controller.dart';
import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';
import 'package:qtc_motoboy/app/theme/theme_app.dart';

import 'app/data/models/user_model.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init('storage');
  Get.put(HomeController());

  var startApp = AppSettings(
      settings: QTCsettings(),
      child: GetMaterialApp(
        title: QTCsettings().nameApp,
        initialRoute: verifyStorage(),
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        defaultTransition: Transition.fadeIn,
        locale: const Locale("pt", "BR"),
      ));

  runApp(startApp);
}

String verifyStorage() {
  GetStorage storage = GetStorage('storage');
  if (storage.read('usuario') == null) {
    return AppPages.INITIAL;
  } else {
    var verify = storage.read("usuario");
    if (verify.runtimeType == User) {
      User user = verify;
      if (user.veiculo!.qtdkmPorLitro != null) {
        return Routes.HOME;
      }
    } else {
      User user = User.fromJson(verify);
      if (user.veiculo!.qtdkmPorLitro != null) {
        return Routes.HOME;
      }
    }
  }
  return AppPages.INITIAL;
}
