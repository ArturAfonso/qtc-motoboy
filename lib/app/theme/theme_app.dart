import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qtc_motoboy/app/settings/motplan_settings.dart';

final ThemeData appTheme = ThemeData(
    primaryColor: QTCsettings().colorPrimaryLight,
    secondaryHeaderColor: QTCsettings().colorSecondaryLight,
    fontFamily: GoogleFonts.openSans().fontFamily,
    primaryTextTheme: TextTheme(bodyText1: TextStyle(color: QTCsettings().textColorPrimaryLight)));
