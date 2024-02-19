import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/model/gc0032a.dart';
import 'package:project_urbanizacion/model/gc0032c.dart';
import 'dart:convert';

class Habitante {
  Gc0032 gc0032;
  List<Gc0032A> gc0032A;
  List<Gc0032C> gc0032C;

  Habitante({
    required this.gc0032,
    required this.gc0032A,
    required this.gc0032C,
  });

  factory Habitante.fromJson(String str) => Habitante.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory Habitante.fromMap(Map<String, dynamic> json) => Habitante(
        gc0032: Gc0032.fromJson(json["Gc0032"]),
        gc0032A:
            List<Gc0032A>.from(json["Gc0032A"].map((x) => Gc0032A.fromJson(x))),
        gc0032C:
            List<Gc0032C>.from(json["Gc0032C"].map((x) => Gc0032C.fromJson(x))),
      );

  Map<String, dynamic> toMap() => {
        "Gc0032": gc0032.toJson(),
        "Gc0032A": List<dynamic>.from(gc0032A.map((x) => x.toJson())),
        "Gc0032C": List<dynamic>.from(gc0032C.map((x) => x.toJson())),
      };
}
