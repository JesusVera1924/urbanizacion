import 'package:flutter/material.dart' show BuildContext, MediaQuery;

class ScreenQueries {
  ScreenQueries._privateConstructor();

  static final instance = ScreenQueries._privateConstructor();

  /// OBTENER ANCHO TOTAL..
  double width(BuildContext context) => MediaQuery.of(context).size.width;

  /// OBTENER ALTO TOTAL...
  double height(BuildContext context) => MediaQuery.of(context).size.height;

  /// ANCHO PERSONALISADO...
  double customWidth(BuildContext context, double divideBy) =>
      (MediaQuery.of(context).size.width / divideBy).truncateToDouble();

  /// ALTO PERSONALISADO...
  double customHeight(BuildContext context, double divideBy) =>
      (MediaQuery.of(context).size.height / divideBy).truncateToDouble();

  /// OBTENER PORCENTAJE DE EL ANCHO TOTAL...
  double customWidthPercent(BuildContext context, double percent) =>
      (MediaQuery.of(context).size.width * percent).truncateToDouble();

  /// OBTENER PORCENTAJE DE EL ALTO TOTAL...
  double customHeightPercent(BuildContext context, double percent) =>
      (MediaQuery.of(context).size.height * percent).truncateToDouble();

  // This isMobile, isTablet, isDesktop helep us later
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1000 &&
      MediaQuery.of(context).size.width >= 850;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  double width2(double max, double column) {
    //230 del SideBar y 45 restante
    double d = (max - 310) / 12 * column;
    //print('$d columna $column');
    return d;
  }
}
