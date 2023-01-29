import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:motplan/app/settings/motplan_settings.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.controller,
    this.buttonFunction,
    required this.title,
  }) : super(key: key);

  final GetxController controller;
  final String title;

  final Function()? buttonFunction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.size.width,
        height: 60,
        child: SizedBox(
          width: Get.size.width,
          child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  // If the button is pressed, return green, otherwise blue
                  if (states.contains(MaterialState.pressed)) {
                    return MOTsettings().textColorPrimaryLight;
                  }
                  return MOTsettings().colorPrimaryLight;
                }),
                side: MaterialStateProperty.resolveWith((states) {
                  // If the button is pressed, return green, otherwise blue
                  if (states.contains(MaterialState.pressed)) {
                    return BorderSide(color: MOTsettings().textColorPrimaryLight, width: 2);
                  }
                  return BorderSide(color: MOTsettings().colorPrimaryLight, width: 2);
                }),
                shape: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)));
                  }
                  return const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)));
                }),
              ),
              onPressed: buttonFunction,
              child: Text(title,
                  maxLines: 1,
                  style:
                      TextStyle(color: MOTsettings().textColorPrimaryDark, fontSize: 20, fontWeight: FontWeight.w400))),
        ));
  }
}
