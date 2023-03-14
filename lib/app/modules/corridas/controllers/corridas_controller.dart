import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qtc_motoboy/app/data/utility.dart';
import 'package:qtc_motoboy/app/modules/home/controllers/home_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/corrida_model.dart';

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

      if (mapacorridas.runtimeType == List<Corrida>) {
        if (listCorridas.isNotEmpty) {
          listCorridas.clear();
        }
        mapacorridas.forEach((element) {
          listCorridas.add(element);
        });

        update();
      } else if (mapacorridas.runtimeType == List<dynamic>) {
        if (listCorridas.isNotEmpty) {
          listCorridas.clear();
        }
        mapacorridas.forEach((element) {
          listCorridas.add(Corrida.fromJson(element));

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
          var teste = await ImageGallerySaver.saveFile('${directory.path}/comprovante_$time.png');
          if (teste['isSuccess'] == true) {
            Get.snackbar(
              'Sucesso',
              'Salvo na galeria',
              colorText: Colors.white,
              snackStyle: SnackStyle.FLOATING,
              backgroundColor: Colors.green,
            );
          } else {
            Get.snackbar('Erro', 'Falha ao salvar na galeria',
                colorText: Colors.white, snackStyle: SnackStyle.FLOATING, backgroundColor: Colors.red);
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('on init');
    /*   cHome.updateModels();
    loadListCorridas(); */
  }
}
