// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qtc_motoboy/app/settings/qtcmotoboy_settings.dart';

class DonateDialog extends StatelessWidget {
  DonateDialog({
    Key? key,
  }) : super(key: key);
  RxBool copied = false.obs;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'QTC Motoboy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                // QR Code
                /*  QrImage(
                  data: "asd654as65da4s6d5a4s6d54",
                  version: QrVersions.auto,
                  size: 200.0,
                ), */
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset("assets/pixInterqtc.png"),
                ),

                // Vencimento
                const Text(
                  'Sua contribuição nos ajuda a manter o aplicativo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),

                // Total
                const Text(
                  'Obrigado',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Botão copia e cola
                Obx(() => OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: copied.value ? Colors.green : QTCsettings().colorPrimaryLight,
                        ),
                      ),
                      onPressed: () {
                        try {
                          Clipboard.setData(const ClipboardData(
                              text:
                                  "00020101021126580014br.gov.bcb.pix0136cd1e45a5-c47b-4a39-a9e7-ae54498f7f165204000053039865802BR5919ARTUR AFONSO TEOBAL6009FORTALEZA62070503***630424E5"));
                          copied.value = true;
                          Future.delayed(const Duration(seconds: 2), () {
                            copied.value = false;
                          });
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      icon: copied.value
                          ? Icon(Icons.check_rounded, size: 15, color: QTCsettings().textColorPrimaryLight)
                          : Icon(Icons.copy, size: 15, color: QTCsettings().textColorPrimaryLight),
                      label: Text(
                        'Copiar chave Pix',
                        style: TextStyle(
                            fontSize: 13, color: copied.value ? Colors.green : QTCsettings().textColorPrimaryLight),
                      ),
                    )),
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
