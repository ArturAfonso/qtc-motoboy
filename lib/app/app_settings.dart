import 'package:flutter/material.dart';
import 'package:qtc_motoboy/app/settings/settings_model.dart';

class AppSettings extends InheritedWidget {
  AppSettings({
    Key? key,
    required this.settings,
    required Widget? child,
  }) : super(key: key, child: child!);

  final SettingsModel settings;

  static AppSettings? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppSettings>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
