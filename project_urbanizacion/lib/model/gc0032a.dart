import 'dart:convert';

class Gc0032A {
  String codEmp;
  String secNic;
  String secRdh;
  String nomRdh;
  String sexRdh;
  DateTime fncRdh;
  String clsRdh;
  String stsRdh;

  Gc0032A({
    required this.codEmp,
    required this.secNic,
    required this.secRdh,
    required this.nomRdh,
    required this.sexRdh,
    required this.fncRdh,
    required this.clsRdh,
    required this.stsRdh,
  });

  factory Gc0032A.fromJson(String str) => Gc0032A.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gc0032A.fromMap(Map<String, dynamic> json) => Gc0032A(
        codEmp: json["codEmp"],
        secNic: json["secNic"],
        secRdh: json["secRdh"],
        nomRdh: json["nomRdh"],
        sexRdh: json["sexRdh"],
        fncRdh: DateTime.parse(json["fncRdh"]),
        clsRdh: json["clsRdh"],
        stsRdh: json["stsRdh"],
      );

  Map<String, dynamic> toMap() => {
        "codEmp": codEmp,
        "secNic": secNic,
        "secRdh": secRdh,
        "nomRdh": nomRdh,
        "sexRdh": sexRdh,
        "fncRdh":
            "${fncRdh.year.toString().padLeft(4, '0')}-${fncRdh.month.toString().padLeft(2, '0')}-${fncRdh.day.toString().padLeft(2, '0')}",
        "clsRdh": clsRdh,
        "stsRdh": stsRdh,
      };
}
