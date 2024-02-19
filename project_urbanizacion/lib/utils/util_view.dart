import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_urbanizacion/style/palette.dart';

class UtilView {
  static Map<int, String> tipoIdentificacion = {
    1: "CEDULA",
    2: "RUC",
    3: "PASAPORTE"
  };
  static Map<int, String> tipoClasificacion = {
    1: "COMUNERO",
    2: "ASPIRANTE A COMUNERO",
    3: "HABITANTE"
  };

  static Map<int, String> tipoPagos = {1: "EFECTIVO", 2: "TARJETA CREDITO"};

  static Map<int, String> tipoClase = {1: "TRANSFERENCIA", 2: "UNIFICACÍON"};

  static Color convertColor(String color) {
    Color colorPrimario = Palette.azulMarino;
    if (color != "") {
      final colorF = color.replaceAll("#", "0xFF");
      return colorPrimario = Color(int.parse(colorF.toUpperCase()));
    }
    return colorPrimario;
  }

  static Map<int, String> tipoSexo = {1: "HOMBRE", 2: "MUJER"};

  static String convertDateToString(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static DateTime convertStringToDate(String cadena) {
    return DateFormat("dd/MM/yyyy").parse(cadena).add(const Duration(hours: 5));
  }

  static String dateFormatDMY(String cadena) {
    DateTime date = DateTime.parse(cadena);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static messageAccess(BuildContext context, String title, String message) {
    ElegantNotification.success(
            title: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            description:
                Text(message, maxLines: 2, overflow: TextOverflow.ellipsis),
            width: 80,
            height: 80)
        .show(context);
  }

  static messageError(BuildContext context, String title, String message) {
    ElegantNotification.error(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(message),
      width: 70,
      height: 60,
    ).show(context);
  }

  static messageInfo(BuildContext context, String title, String message) {
    ElegantNotification.info(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      description: Text(message),
      width: 70,
      height: 60,
    ).show(context);
  }

  static messageGeneral(
      BuildContext context, String message, IconData iconData, Color color) {
    ElegantNotification(
            title: const Text("Notificación",
                style: TextStyle(fontWeight: FontWeight.bold)),
            description:
                Text(message, overflow: TextOverflow.ellipsis, maxLines: 2),
            icon: Icon(iconData, color: color),
            progressIndicatorColor: color,
            width: 70,
            height: 70)
        .show(context);
  }

  static List<String> generarListaRangoAnios(int anioInicial, int anioFinal) {
    List<String> listaAnios = [];

    for (int i = anioInicial; i <= anioFinal; i++) {
      int siguienteAnio = i + 1;
      String rangoAnios = '$i-$siguienteAnio';
      listaAnios.add(rangoAnios.trim());
    }

    return listaAnios;
  }
}