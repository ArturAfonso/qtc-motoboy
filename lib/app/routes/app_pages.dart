import 'package:get/get.dart';
import 'package:motplan/app/modules/home/views/edit_info_veic_view.dart';

import 'package:motplan/app/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:motplan/app/modules/onboarding/views/onboarding_view.dart';

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
      page: () => EditInfoVeicView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
  ];
}
