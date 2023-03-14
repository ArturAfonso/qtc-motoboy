// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qtc_motoboy/app/data/utility.dart';
import 'package:qtc_motoboy/app/modules/corridas/controllers/corridas_controller.dart';
import 'package:qtc_motoboy/app/routes/app_pages.dart';

import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';

import '../../../data/models/corrida_model.dart';
import '../controllers/home_controller.dart';

class PrintDialog extends StatefulWidget {
  final Corrida corrida;
  const PrintDialog({
    Key? key,
    required this.corrida,
  }) : super(key: key);

  @override
  State<PrintDialog> createState() => _PrintDialogState();
}

class _PrintDialogState extends State<PrintDialog> {
  HomeController cHome = Get.find();
  CorridasController cCorridas = CorridasController();

  @override
  void dispose() {
    super.dispose();
    debugPrint('disposado');
    cHome.preencheCamposHome();
    cHome.imprimir.value = false;
    try {
      Future.delayed(const Duration(milliseconds: 200), () {
        Get.offAndToNamed(Routes.HOME);
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey globalKey = GlobalKey();
    DateTime dat = DateTime.parse(widget.corrida.dataHora);
    String dia = DateFormat('kk:mm / dd-MM-yyyy').format(dat);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            key: globalKey,
            child: Container(
              margin: const EdgeInsets.all(10),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          // Lista de produtos
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 150,
                              child: ListView(
                                children: [
                                  const Text(
                                    "Comprovante",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(
                                      // height: 5,
                                      ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Data da entrega: ',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(dia.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Preço do combustivel: ',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(Utility().priceToCurrency(
                                              Utility().convertToDouble(widget.corrida.precoCombustivel))),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Distância: ',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('${widget.corrida.distanciaDaCorrida} Km'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Total
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Valor total: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: widget.corrida.valorCobrado.toString(),
                            style: const TextStyle(
                              color: /* lucrofinalCalculado.contains("-") ? Colors.red : */ Colors.green,
                            ),
                          )
                          /* TextSpan(text: Utility().priceToCurrency(10.0) //utilsServices.priceToCurrency(order.total),
                                ), */
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                  child: Visibility(
                    visible: true,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: QTCsettings().colorPrimaryLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        cCorridas.captureWidget(globalKey, share: false);
                      },
                      icon: const Icon(Icons.save),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Salvar',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                  child: Visibility(
                    visible: true,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: QTCsettings().colorPrimaryLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        cCorridas.captureWidget(globalKey, share: true);
                      },
                      icon: const Icon(Icons.share),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Compartilhar',
                          style: TextStyle(fontSize: 13),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
