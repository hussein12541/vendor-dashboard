import 'package:flutter/material.dart';
import 'package:store_dash_board/core/utils/styles/size_config.dart';

abstract class AppStyles {
  static TextStyle _generateStyle(
      BuildContext context, {
        required double fontSize,
        required FontWeight fontWeight,
        Color? color,
      }) {
    return TextStyle(
      fontFamily: 'Cairo',
      fontSize: getResponsiveFontSize(context, fontSize: fontSize),
      fontWeight: fontWeight,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,

    );
  }

  // ============ Regular Styles ============
  static TextStyle regular12(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 12, fontWeight: FontWeight.w400, color: color);

  static TextStyle regular14(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 14, fontWeight: FontWeight.w400, color: color);

  static TextStyle regular16(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 16, fontWeight: FontWeight.w400, color: color);

  static TextStyle regular18(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 18, fontWeight: FontWeight.w400, color: color);

  static TextStyle regular20(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 20, fontWeight: FontWeight.w400, color: color);

  // ============ Medium Styles ============
  static TextStyle medium14(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 14, fontWeight: FontWeight.w500, color: color);

  static TextStyle medium16(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 16, fontWeight: FontWeight.w500, color: color);

  static TextStyle medium18(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 18, fontWeight: FontWeight.w500, color: color);

  static TextStyle medium20(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 20, fontWeight: FontWeight.w500, color: color);

  // ============ SemiBold Styles ============
  static TextStyle semiBold14(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 14, fontWeight: FontWeight.w600, color: color);
  static TextStyle semiBold16(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 16, fontWeight: FontWeight.w600, color: color);

  static TextStyle semiBold18(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 18, fontWeight: FontWeight.w600, color: color);

  static TextStyle semiBold20(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 20, fontWeight: FontWeight.w600, color: color);

  static TextStyle semiBold24(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 24, fontWeight: FontWeight.w600, color: color);

  static TextStyle semiBold28(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 28, fontWeight: FontWeight.w600, color: color);

  // ============ Bold Styles ============
  static TextStyle bold16(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 16, fontWeight: FontWeight.w700, color: color ?? Theme.of(context).primaryColor);

  static TextStyle bold20(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 20, fontWeight: FontWeight.w700, color: color);

  static TextStyle bold24(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 24, fontWeight: FontWeight.w700, color: color);

  static TextStyle bold32(BuildContext context, {Color? color}) =>
      _generateStyle(context, fontSize: 32, fontWeight: FontWeight.w700, color: color);

  static TextStyle _baseStyle(
      BuildContext context, {
        required double fontSize,
        required FontWeight fontWeight,
      }) {
    return TextStyle(
      fontFamily: 'Cairo',

      fontSize: getResponsiveFontSize(context, fontSize: fontSize),
      fontWeight: fontWeight,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black,
    );
  }
}

double getResponsiveFontSize(context, {required double fontSize}) {

  double scaleFactor = getScaleFactor(context);

  double responsiveFontSize = fontSize * scaleFactor;



  double lowerLimit = fontSize * .8;

  double upperLimit = fontSize * 1.2;



  return responsiveFontSize.clamp(lowerLimit, upperLimit);

}



double getScaleFactor(context) {

  // var dispatcher = PlatformDispatcher.instance;

  // var physicalWidth = dispatcher.views.first.physicalSize.width;

  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;

  // double width = physicalWidth / devicePixelRatio;



  double width = MediaQuery.sizeOf(context).width;

  if (width < SizeConfig.tablet) {

    return width / 810;

  } else if (width < SizeConfig.desktop) {

    return width / 1010;

  } else {

    return width / 1920;

  }

}

