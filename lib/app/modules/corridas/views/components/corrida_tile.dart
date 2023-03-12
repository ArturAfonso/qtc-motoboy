/* // ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qtc_motoboy/app/data/utility.dart';
import 'package:qtc_motoboy/app/modules/corridas/controllers/corridas_controller.dart';
import 'package:qtc_motoboy/app/modules/home/controllers/home_controller.dart';
import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';

class CorridaTile extends StatelessWidget {
  Corrida corrida;
  GlobalKey chave;
  CorridaTile({Key? key, required this.corrida, required this.chave}) : super(key: key);
  HomeController cHome = Get.find();
  CorridasController controller = CorridasController();

  @override
  Widget build(BuildContext context) {
    String lucrofinalCalculado = Utility().priceToCurrency(cHome.calcularCustoELucro(
        info: "lucroFinal",
        precoCobradoMotoboy: corrida.precoCobradoPeloMotoboyNoDia!,
        precoGasolina: corrida.precoDaGasolinaNoDia!,
        distanciaCorridaKm: corrida.distanciaDaCorridaKm!));
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent, backgroundColor: Colors.white),
        child: ExpansionTile(
          initiallyExpanded: false,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*    //Text('Pedido: ${corrida.custoTotal}'),
              Text(
                  "R\$ ${cHome.calcularCustoELucro(info: "custoTotal", precoCobradoMotoboy: corrida.precoCobradoPeloMotoboyNoDia!, precoGasolina: corrida.precoDaGasolinaNoDia!, distanciaCorridaKm: corrida.distanciaDaCorridaKm!).toString()}"),
              */
              Text("Corrida ${corrida.idCorrida}"),
              Text(
                Utility().formatDateTime(DateTime.parse(corrida.dataDacorrida!)),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RepaintBoundary(
              key: chave,
              child: Container(
                color: Colors.white,
                child: Column(
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
                                    "Detalhes",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Encargos da corrida: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                            style: const TextStyle(color: Colors.red),
                                            text: Utility().priceToCurrency(cHome.calcularCustoELucro(
                                                info: 'custoTotal',
                                                precoCobradoMotoboy: corrida.precoCobradoPeloMotoboyNoDia!,
                                                precoGasolina: corrida.precoDaGasolinaNoDia!,
                                                distanciaCorridaKm: corrida.distanciaDaCorridaKm!)))
                                        /* TextSpan(text: Utility().priceToCurrency(10.0) //utilsServices.priceToCurrency(order.total),
                          ), */
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Valor cobrado pela corrida: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                            style: const TextStyle(color: Colors.blue),
                                            text: Utility().priceToCurrency(corrida.precoCobradoPeloMotoboyNoDia!))
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
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Lucro final: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: lucrofinalCalculado,
                            style: TextStyle(
                              color: lucrofinalCalculado.contains("-") ? Colors.red : Colors.green,
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
            // Botão pagamento
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
                    controller.captureWidget(chave, share: true);
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
      ),
    );
  }
}
 */