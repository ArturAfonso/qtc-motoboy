// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                              children: const [
                                Text(
                                  "Detalhes",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Encargos da corrida: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                          style: TextStyle(color: Colors.red),
                                          text:
                                              'teste') /* Utility().priceToCurrency(cHome.calcularCustoELucro(
                                              info: 'custoTotal',
                                              precoCobradoMotoboy: corrida.precoCobradoPeloMotoboyNoDia!,
                                              precoGasolina: corrida.precoDaGasolinaNoDia!,
                                              distanciaCorridaKm: corrida.distanciaDaCorridaKm!))) */
                                      /* TextSpan(text: Utility().priceToCurrency(10.0) //utilsServices.priceToCurrency(order.total),
                              ), */
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Valor cobrado pela corrida: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                          style: TextStyle(color: Colors.blue),
                                          text:
                                              'teste2' /* Utility().priceToCurrency(corrida.precoCobradoPeloMotoboyNoDia!) */)
                                      /* TextSpan(text: Utility().priceToCurrency(10.0) //utilsServices.priceToCurrency(order.total),
                              ), */
                                    ],
                                  ),
                                ),
                              ] /* order.items.map((orderItem) {
                                  return _OrderItemWidget(
                                    utilsServices: utilsServices,
                                    orderItem: orderItem,
                                  );
                                }).toList() */
                              ,
                            ),
                          ),
                        ),

                        // Divisão
                        /*   VerticalDivider(
                            color: Colors.grey.shade300,
                            thickness: 2,
                            width: 8,
                          ), */

                        // Status do pedido
                        /* const Expanded(
                            flex: 2,
                            child: Text(
                                "status") /* OrderStatusWidget(
                              status: order.status,
                              isOverdue: order.overdueDateTime.isBefore(DateTime.now()),
                            ) */
                            ,
                          ), */
                      ],
                    ),
                  ),

                  // Total
                  const Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: 'Lucro final: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'teste3' /* lucrofinalCalculado */,
                          style: TextStyle(
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  //cHome.captureWidget(globalKey, share: true);
                  /* 
                    showDialog(
                      context: context,
                      builder: (_) {
                        return PaymentDialog(
                          order: order,
                        );
                      },
                    ); */
                },
                icon: const Icon(Icons.print),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('Imprimir comprovante'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
