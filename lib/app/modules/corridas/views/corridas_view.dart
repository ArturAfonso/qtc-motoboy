import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';

import '../controllers/corridas_controller.dart';
import 'components/corrida_tile.dart';

class CorridasView extends StatefulWidget {
  const CorridasView({super.key});

  @override
  State<CorridasView> createState() => _CorridasViewState();
}

class _CorridasViewState extends State<CorridasView> {
  CorridasController controller = CorridasController();
  @override
  Widget build(BuildContext context) {
    controller.loadListCorridas();
    return RefreshIndicator(
      onRefresh: controller.reload,
      child: Scaffold(
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
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      controller.loadListCorridas();
                    });
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: QTCsettings().textColorPrimaryLight,
                  ))
            ],
          ),
          // ignore: prefer_is_empty
          body: controller.listCorridas.length > 0
              ? GetBuilder<CorridasController>(
                  init: controller,
                  initState: (_) {},
                  builder: (_) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (_, index) => const SizedBox(height: 5),
                      itemBuilder: (_, index) {
                        final GlobalKey globalKey = GlobalKey();
                        return CorridaTile(chave: globalKey, corrida: controller.listCorridas[index]);
                        /* return Container(
                      color: Colors.amber,
                    ); */
                      },
                      itemCount: controller.listCorridas.length,
                    );
                  },
                )
              : Container(
                  color: Colors.white,
                  height: Get.size.height,
                )),
    );
  }
}
