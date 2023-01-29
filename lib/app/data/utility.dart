import 'package:all_validations_br/all_validations_br.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Utility {
  static String returnOnlyNumbers(String txt) {
    return AllValidations.removeCharacters(txt);
  }

  static void unfocusTextField({BuildContext? contexto}) {
    if (contexto == null) {
      FocusScope.of(Get.context!).unfocus();
      FocusScope.of(Get.overlayContext!).unfocus();
    } else {
      FocusScope.of(contexto).unfocus();
    }
  }

  static FormFieldValidator compare(TextEditingController? valueEC, String message) {
    return (value) {
      final valueCompare = valueEC?.text ?? '';
      if (value == null || (value != null && value != valueCompare)) {
        return message;
      }
      return null;
    };
  }

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return numberFormat.format(price);
  }

  double convertToDouble(String value) {
    value = value.removeAllWhitespace;
    value = value.trim();
    value = value.replaceFirst(RegExp(r','), '.');
    if (value.contains(",")) {
      value = value.replaceAll(RegExp(r','), '');
    }
    List splitValue = [];

    splitValue = value.split('.');
    value = splitValue[0];
    if (splitValue.length > 1) {
      if (splitValue.length == 2) {
        value += ".";
        value += splitValue[1];
      } else if (splitValue.length >= 3) {
        value += ".";
        value += splitValue[1];
        value += splitValue[2];
      }
    }
    double valor = double.parse(value);
    return valor;
  }

  /*  void showToast({
    required String message,
    bool isError = false,
  }) {
    /*  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 14,
    ); */
    Toast.show(
      message,
      duration: Toast.lengthShort,
      gravity: Toast.bottom,
      backgroundColor: isError ? VEGsettings().errorColor : Colors.white,
      textStyle: TextStyle(fontSize: 14, color: isError ? Colors.white : Colors.black),

      // webTexColor: isError ? Colors.white : Colors.black,
    );
  } */

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }
}
