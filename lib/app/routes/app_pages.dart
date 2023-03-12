// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import 'package:qtc_motoboy/app/modules/home/views/edit_info_veic_view.dart';
import 'package:qtc_motoboy/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:qtc_motoboy/app/modules/onboarding/views/onboarding_view.dart';

import '../modules/corridas/bindings/corridas_binding.dart';
import '../modules/corridas/views/corridas_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_INFO_VEIC,
      page: () => const EditInfoVeicView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.CORRIDAS,
      page: () => const CorridasView(),
      binding: CorridasBinding(),
    ),
  ];
}
