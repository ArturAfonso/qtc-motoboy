import 'package:get/get.dart';
import 'package:qtc_motoboy/app/data/models/corrida_model.dart';
import 'package:qtc_motoboy/app/modules/home/controllers/home_controller.dart';

class CorridasController extends GetxController {
  HomeController cHome = Get.find();
  RxList<Corrida> listCorridas = <Corrida>[].obs;

  @override
  void onInit() {
    super.onInit();
    cHome.updateModels();
    listCorridas.value = [
      Corrida(veiculo: cHome.veiculo, custos: cHome.custos),
      Corrida(veiculo: cHome.veiculo, custos: cHome.custos),
      Corrida(veiculo: cHome.veiculo, custos: cHome.custos)
    ];
  }
}
