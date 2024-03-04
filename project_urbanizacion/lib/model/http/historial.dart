import 'dart:convert';
import 'package:project_urbanizacion/model/gc0020cob.dart';

class Historial {
  Gc0020Cob cabecera;
  List<Gc0020Cob> detalle;

  Historial({
    required this.cabecera,
    required this.detalle,
  });

  factory Historial.fromJson(String str) => Historial.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Historial.fromMap(Map<String, dynamic> json) => Historial(
        cabecera: Gc0020Cob.fromMap(json["cabecera"]),
        detalle: List<Gc0020Cob>.from(
            json["detalle"].map((x) => Gc0020Cob.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "cabecera": cabecera.toMap(),
        "detalle": List<Gc0020Cob>.from(detalle.map((x) => x.toMap())),
      };
}
