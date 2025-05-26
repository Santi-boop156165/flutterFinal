import 'package:flutter/material.dart';

import 'color_utils.dart';

class FormUtils {
  static final ButtonStyle buttonStyle = createButtonStyle(ColorUtils.main);

  static const TextStyle textFormFieldStyle = TextStyle(fontSize: 20);

  /// Dark text style for form fields.
  static TextStyle darkTextFormFieldStyle = TextStyle(
    fontSize: 20,
    color: ColorUtils.white,
  );


  static ButtonStyle createButtonStyle(Color backgroundColor) {
    return ButtonStyle(
      textStyle: WidgetStateProperty.all(TextStyle(
        fontSize: 20,
        color: ColorUtils.white,
      )),
      minimumSize: WidgetStateProperty.all(const Size(150, 50)),
      backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  
  static InputDecoration createInputDecorative(String text,
      {bool? dark, IconData? icon}) {
    dark ??= false;
    final color = dark ? ColorUtils.mainLight : ColorUtils.main;
    final errorColor = dark ? ColorUtils.errorLight : ColorUtils.error;

    return InputDecoration(
      icon: icon != null ? Icon(icon) : null,
      iconColor: color,
      errorStyle: TextStyle(color: errorColor),
      errorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: errorColor)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),
      border: UnderlineInputBorder(borderSide: BorderSide(color: color)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: color)),
      focusedErrorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: errorColor)),
      focusColor: color,
      labelStyle: TextStyle(color: color),
      labelText: text,
    );
  }
}
