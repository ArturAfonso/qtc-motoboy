import 'package:flutter/material.dart';
import 'package:motplan/app/settings/settings_model.dart';

class MOTsettings implements SettingsModel {
  //parameters
  @override
  String nameApp = "QTC MOTOBOY";
  @override
  String idPlayStore = "";
  @override
  String idAppleStore = "";
  @override
  String logo = "", logoColored = "", logoSplash = "";

  //primary
  @override
  @override
  Color colorPrimaryLight = const Color.fromRGBO(255, 79, 91, 1);
  @override
  Color colorPrimaryDark = const Color.fromRGBO(255, 106, 0, 1);
  @override
  Color textColorPrimaryLight = const Color.fromRGBO(21, 25, 44, 1);
  @override
  Color textColorPrimaryDark = Colors.white;

  //secondary
  @override
  Color colorSecondaryLight = const Color.fromRGBO(85, 31, 255, 1);
  @override
  Color colorSecondaryDark = const Color.fromRGBO(84, 95, 255, 1);
  @override
  Color textColorSecondaryLight = const Color.fromRGBO(146, 149, 158, 1);
  @override
  Color textColorSecondaryDark = const Color.fromRGBO(167, 164, 197, 1);

  //Tertiary
  @override
  Color colorTertiaryLight = const Color.fromRGBO(0, 183, 254, 1);
  @override
  Color colorTertiaryDark = const Color.fromRGBO(0, 159, 255, 1);
  @override
  Color textColorTertiaryLight = const Color.fromRGBO(208, 210, 218, 1);
  @override
  Color textColorTertiaryDark = const Color.fromRGBO(131, 127, 163, 1);

  //Quaternary
  @override
  Color colorQuaternaryLight = const Color.fromRGBO(253, 34, 84, 1);
  @override
  Color colorQuaternaryDark = const Color.fromRGBO(245, 49, 93, 1);
  @override
  Color textColorQuaternaryLight = const Color.fromRGBO(245, 245, 247, 1);
  @override
  Color textColorQuaternaryDark = const Color.fromRGBO(62, 58, 102, 1);

  @override
  Color errorColor = Colors.red.shade600;
  @override
  Color sucessColor = Colors.green.shade600;
}
