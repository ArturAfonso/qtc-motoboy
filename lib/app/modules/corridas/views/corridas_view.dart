import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qtc_motoboy/app/modules/corridas/views/components/corrida_tile.dart';
import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';

import '../controllers/corridas_controller.dart';

class CorridasView extends GetView<CorridasController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: QTCsettings().colorPrimaryLight,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Histórico de Corridas',
          style: TextStyle(color: QTCsettings().textColorPrimaryLight, fontWeight: FontWeight.w800, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemBuilder: (_, index) =>
            CorridaTile(controller: controller.cHome.cOnboarding, corrida: controller.listCorridas[index]),
        itemCount: controller.listCorridas.length,
      ),
    );
  }
}
