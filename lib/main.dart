import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qtc_motoboy/app/app_settings.dart';
import 'package:qtc_motoboy/app/modules/home/controllers/home_controller.dart';
import 'package:qtc_motoboy/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';
import 'package:qtc_motoboy/app/theme/theme_app.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init('storage');
  Get.put(OnboardingController());
  Get.put(HomeController());
  OnboardingController cOnboarding = Get.find();

  var startApp = AppSettings(
      settings: QTCsettings(),
      child: GetMaterialApp(
        title: QTCsettings().nameApp,
        initialRoute: cOnboarding.verifyStorage(),
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        defaultTransition: Transition.fadeIn,
      ));

  runApp(startApp);
}
