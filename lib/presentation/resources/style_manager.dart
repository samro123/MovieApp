import 'package:flutter/material.dart';
import 'package:movie_video/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily, Color color, FontWeight fontWeight){
    return TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: color, fontWeight: fontWeight);
}

//regular style
TextStyle getRegularStyle({double fontSize = FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, color, FontWeightManager.regular);
}

//bold style
TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, color, FontWeightManager.bold);
}

// SemiBold style
TextStyle getSemiBoldStyle({double fontSize = FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, color, FontWeightManager.semiBold);
}

// medium style
TextStyle getMediumStyle({double fontSize = FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, color, FontWeightManager.medium);
}