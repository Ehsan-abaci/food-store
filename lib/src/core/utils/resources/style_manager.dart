import 'package:flutter/material.dart';
import 'font_manager.dart';

  TextStyle _getTextStyle(
    String fontFamily, double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

TextStyle getRegularStyle(
    {double fontSize = 12, @required Color? color}) {
  return _getTextStyle(
    FontConstants.fontFamily,
    fontSize,
    FontWeightManager.regular,
    color!,
  );

}
TextStyle getMediumStyle(
    {double fontSize = 12, @required Color? color}) {
  return _getTextStyle(
    FontConstants.fontFamily,
    fontSize,
    FontWeightManager.medium,
    color!,
  );
}
TextStyle getSemiBoldStyle(
    {double fontSize = 12, @required Color? color}) {
  return _getTextStyle(
    FontConstants.fontFamily,
    fontSize,
    FontWeightManager.semiBold,
    color!,
  );
}
TextStyle getBoldStyle(
    {double fontSize = 12, @required Color? color}) {
  return _getTextStyle(
    FontConstants.fontFamily,
    fontSize,
    FontWeightManager.bold,
    color!,
  );
}
