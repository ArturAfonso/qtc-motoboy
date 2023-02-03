import 'package:get/get.dart';

import '../controllers/corridas_controller.dart';

class CorridasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CorridasController>(
      () => CorridasController(),
    );
  }
}
