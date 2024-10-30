import 'package:flutter/material.dart';

class ColorManager{
  static Color primary = HexColor.fromHex('#262525');
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity = HexColor.fromHex("#B3ED9728");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");

  // new colors
  static Color darkPrimary = HexColor.fromHex("#262525");
  static Color grey1 = HexColor.fromHex("#575757");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color buttonColor = HexColor.fromHex("#F60002");
  static Color error = HexColor.fromHex("#e61f34"); // red color
  static Color black = HexColor.fromHex("#000000");
  static Color black1 = HexColor.fromHex("#1E1E1E");
  static Color yellow = HexColor.fromHex("#F7F700");
}

extension HexColor on Color{
 static Color fromHex(String hexColorString){
   hexColorString = hexColorString.replaceAll('#', '');
   if(hexColorString.length == 6){
     hexColorString = "FF" + hexColorString;
   }
   return Color(int.parse(hexColorString, radix: 16));
 }
}