import 'package:flutter/material.dart';

abstract class SettingsModel {
  final String nameApp, idPlayStore, idAppleStore;

  final String logo, logoColored, logoSplash;
  //
  //
  //primary Colors
  final Color colorPrimaryLight, colorPrimaryDark, textColorPrimaryLight, textColorPrimaryDark;
  //second colors
  final Color colorSecondaryLight, colorSecondaryDark, textColorSecondaryLight, textColorSecondaryDark;
  //Tertiary colors
  final Color colorTertiaryLight, colorTertiaryDark, textColorTertiaryLight, textColorTertiaryDark;
  //Quaternary colors
  final Color colorQuaternaryLight, colorQuaternaryDark, textColorQuaternaryLight, textColorQuaternaryDark;

  final Color errorColor, sucessColor;

  SettingsModel(
    this.nameApp,
    this.idPlayStore,
    this.idAppleStore,
    this.logo,
    this.logoColored,
    this.logoSplash,
    this.errorColor,
    this.sucessColor, {
    required this.colorPrimaryLight,
    required this.colorPrimaryDark,
    required this.textColorPrimaryLight,
    required this.textColorPrimaryDark,
    required this.colorSecondaryLight,
    required this.colorSecondaryDark,
    required this.textColorSecondaryLight,
    required this.textColorSecondaryDark,
    required this.colorTertiaryLight,
    required this.colorTertiaryDark,
    required this.textColorTertiaryLight,
    required this.textColorTertiaryDark,
    required this.colorQuaternaryLight,
    required this.colorQuaternaryDark,
    required this.textColorQuaternaryLight,
    required this.textColorQuaternaryDark,
  });
}
