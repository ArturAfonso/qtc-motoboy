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

  double convertToDouble(String currency) {
    return double.parse(currency.replaceAll('.', '').replaceAll(',', '.'));
  }

  String removeZeros(double value) {
    String result = value.toString().endsWith(".0") ? value.toString().split('.')[0] : value.toString();

    return result;
  }

/*   double convertToDouble(String value) {
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
  } */

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

  static String formatDate(String date,
      {String prefix = "",
      bool asIsoFormat = false,
      bool toLocale = true,
      bool compactData = false,
      String format = "dd/MM/yyyy - HH:mm"}) {
    initializeDateFormatting();

    if (date.isEmpty) {
      return "";
    }
    if (asIsoFormat) {
      return DateTime.parse(date).toIso8601String();
    }
    DateTime oDate = toLocale ? DateTime.parse(date).toLocal() : DateTime.parse(date);
    DateFormat formattedDate;
    if (compactData) {
      // formattedDate = DateFormat('dd-MM-yyyy_HH-mm', Get.locale.toString());
      formattedDate = DateFormat('dd-MM-yyyy_HH-mm', Get.deviceLocale.toString());
      return "$prefix${formattedDate.format(oDate)}";
    } else {
      formattedDate = DateFormat(format, Get.locale.toString());
      if (prefix.isNotEmpty) {
        return "$prefix ${formattedDate.format(oDate)}";
      } else {
        return formattedDate.format(oDate);
      }
    }
  }
}
