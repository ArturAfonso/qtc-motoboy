import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qtc_motoboy/app/data/models/corrida_model.dart';
import 'package:qtc_motoboy/app/data/utility.dart';
import 'package:qtc_motoboy/app/modules/home/controllers/home_controller.dart';
import 'package:share_plus/share_plus.dart';

class CorridasController extends GetxController {
  HomeController cHome = Get.find();
  List<Corrida> listCorridas = <Corrida>[];
  GetStorage storage = GetStorage('storage');

  Future<void> reload() async {
    loadListCorridas();
  }

  loadListCorridas() {
    if (storage.read('corridas') == null) {
    } else {
      var mapacorridas = storage.read("corridas");
      print(mapacorridas.runtimeType.toString());
      if (mapacorridas.runtimeType.toString() == "List<Corrida>") {
        if (listCorridas.isNotEmpty) {
          listCorridas.clear();
        }
        mapacorridas.forEach((element) {
          print(element);
        });

        print(listCorridas);
        print(listCorridas.length);
        update();
      } else if (mapacorridas.runtimeType.toString() == "List<dynamic>") {
        if (listCorridas.isNotEmpty) {
          listCorridas.clear();
        }
        mapacorridas.forEach((element) {
          listCorridas.add(Corrida.fromJson(element));
          print(listCorridas.length);
          update();
        });
      }
    }
  }

  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

/*   Future<Uint8List> captureWidget(GlobalKey key) async {
    final  boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    //globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?

    final ui.Image image = await boundary.toImage();

    final ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData.buffer.asUint8List();

    return pngBytes;
  } */

  captureWidget(GlobalKey globalKey, {bool share = false}) async {
    try {
      final boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      final image = await boundary?.toImage();
      final byteData = await image?.toByteData(format: ImageByteFormat.png);
      final imageBytes = byteData?.buffer.asUint8List();
      final String time = Utility.formatDate(DateTime.now().toString(), compactData: true);

      if (imageBytes != null) {
        var directory = Platform.isAndroid
            ? (await getExternalStorageDirectories(type: StorageDirectory.downloads))!.first
            : await getApplicationSupportDirectory();

        var imagePath = await File('${directory.path}/comprovante_$time.png').create();
        await imagePath.writeAsBytes(imageBytes);

        if (share) {
          // ignore: deprecated_member_use
          Share.shareFiles(['${directory.path}/comprovante_$time.png']);
        } else {
          await ImageGallerySaver.saveFile('${directory.path}/comprovante_$time.png');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    cHome.updateModels();
    loadListCorridas();

    /* 
    listCorridas.value = [
      Corrida(
          idCorrida: idGenerator(),
          dataDacorrida: "10/10/10",
          distanciaDaCorridaKm: 50,
          kmMedioRevisaoVeiculoNoDia: 10000.00,
          kmMedioTrocaDeOleoNoDia: 3000,
          kmPorLitroVeiculoNoDia: 45,
          precoCobradoPeloMotoboyNoDia: 30,
          precoDaGasolinaNoDia: 5.99,
          valorMedioRevisaoVeiculoNoDia: 150,
          valorTrocaDeOleoNoDia: 30),
      Corrida(
          idCorrida: idGenerator(),
          dataDacorrida: "10/10/10",
          distanciaDaCorridaKm: 50,
          kmMedioRevisaoVeiculoNoDia: 10000.00,
          kmMedioTrocaDeOleoNoDia: 3000,
          kmPorLitroVeiculoNoDia: 45,
          precoCobradoPeloMotoboyNoDia: 70,
          precoDaGasolinaNoDia: 5.99,
          valorMedioRevisaoVeiculoNoDia: 150,
          valorTrocaDeOleoNoDia: 30),
      Corrida(
          idCorrida: idGenerator(),
          dataDacorrida: "10/10/10",
          distanciaDaCorridaKm: 50,
          kmMedioRevisaoVeiculoNoDia: 10000.00,
          kmMedioTrocaDeOleoNoDia: 3000,
          kmPorLitroVeiculoNoDia: 45,
          precoCobradoPeloMotoboyNoDia: 45,
          precoDaGasolinaNoDia: 5.99,
          valorMedioRevisaoVeiculoNoDia: 150,
          valorTrocaDeOleoNoDia: 30),
    ]; */
  }
}
