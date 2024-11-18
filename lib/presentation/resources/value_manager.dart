import 'package:flutter/material.dart';

class AppMargin{
  static const double m5 = 5.0;
  static const double m8 = 8.0;
  static const double m10 = 10.0;
  static const double m12 = 12.0;
  static const double m14 = 14.0;
  static const double m15 = 15.0;
  static const double m16 = 16.0;
  static const double m18 = 18.0;
  static const double m20 = 20.0;
  static const double m30 = 30.0;
}

class AppPadding{
  static const double p2 = 2.0;
  static const double p5 = 5.0;
  static const double p8 = 8.0;
  static const double p10 = 10.0;
  static const double p12 = 12.0;
  static const double p14 = 14.0;
  static const double p16 = 16.0;
  static const double p18= 18.0;
  static const double p20 = 20.0;
  static const double p25 = 25.0;
  static const double p28 = 28.0;
  static const double p30 = 30.0;
  static const double p100 = 100.0;
}

class AppSize{
  static const double s0 = 0;
  static const double s1 = 1;
  static const double s1_5 = 1.5;
  static const double s4 = 4.0;
  static const double s5 = 5.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s15 = 15.0;
  static const double s16 = 16.0;
  static const double s18= 18.0;
  static const double s20 = 20.0;
  static const double s23 = 23.0;
  static const double s25 = 25.0;
  static const double s28= 28.0;
  static const double s30= 30.0;
  static const double s32= 32.0;
  static const double s40= 40.0;
  static const double s50= 50.0;
  static const double s53= 53.0;
  static const double s56= 56.0;
  static const double s60 = 60.0;
  static const double s65= 65.0;
  static const double s70= 70.0;
  static const double s100= 100.0;
  static const double s120= 120.0;
  static const double s140= 140.0;
  static const double s160= 160.0;
  static const double s180= 180.0;
  static const double s200= 200.0;
  static const double s250= 250.0;
  static const double s300= 300.0;
}
class AppHeight {
  static double h15(BuildContext context) => MediaQuery.of(context).size.height * 0.15;
  static double h20(BuildContext context) => MediaQuery.of(context).size.height * 0.20;
  static double h25(BuildContext context) => MediaQuery.of(context).size.height * 0.25;
  static double h27(BuildContext context) => MediaQuery.of(context).size.height * 0.27;
  static double h50(BuildContext context) => MediaQuery.of(context).size.height * 0.50;
  static double h47(BuildContext context) => MediaQuery.of(context).size.height * 0.47;
  static double h75(BuildContext context) => MediaQuery.of(context).size.height * 0.75;
  static double h85(BuildContext context) => MediaQuery.of(context).size.height * 0.85;
  static double h100(BuildContext context) => MediaQuery.of(context).size.height;
}

class AppWidth {
  static double w50(BuildContext context) => MediaQuery.of(context).size.width * 0.50;
  static double w25(BuildContext context) => MediaQuery.of(context).size.width * 0.25;
  static double w75(BuildContext context) => MediaQuery.of(context).size.width * 0.75;
  static double w100(BuildContext context) => MediaQuery.of(context).size.width;
}
class AppBottom {
  static double bottom(BuildContext context) =>
      MediaQuery
          .of(context)
          .viewInsets
          .bottom;
}
class DurationConstant{
  static const int d300 = 300;
}