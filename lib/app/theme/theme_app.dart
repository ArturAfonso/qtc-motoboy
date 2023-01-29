import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motplan/app/settings/motplan_settings.dart';

final ThemeData appTheme = ThemeData(
    primaryColor: MOTsettings().colorPrimaryLight,
    secondaryHeaderColor: MOTsettings().colorSecondaryLight,
    fontFamily: GoogleFonts.openSans().fontFamily,
    primaryTextTheme: TextTheme(bodyText1: TextStyle(color: MOTsettings().textColorPrimaryLight)));
