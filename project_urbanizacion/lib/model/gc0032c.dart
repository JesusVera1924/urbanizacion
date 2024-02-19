import 'dart:convert';

class Gc0032C {
  String codEmp;
  String secNic;
  String secIru;
  String nomIru;
  String tmvIru;
  String bznIru;
  String vinIru;
  String stsIru;

  Gc0032C({
    required this.codEmp,
    required this.secNic,
    required this.secIru,
    required this.nomIru,
    required this.tmvIru,
    required this.bznIru,
    required this.vinIru,
    required this.stsIru,
  });

  factory Gc0032C.fromJson(String str) => Gc0032C.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gc0032C.fromMap(Map<String, dynamic> json) => Gc0032C(
        codEmp: json["codEmp"],
        secNic: json["secNic"],
        secIru: json["secIru"],
        nomIru: json["nomIru"],
        tmvIru: json["tmvIru"],
        bznIru: json["bznIru"],
        vinIru: json["vinIru"],
        stsIru: json["stsIru"],
      );

  Map<String, dynamic> toMap() => {
        "codEmp": codEmp,
        "secNic": secNic,
        "secIru": secIru,
        "nomIru": nomIru,
        "tmvIru": tmvIru,
        "bznIru": bznIru,
        "vinIru": vinIru,
        "stsIru": stsIru,
      };
}
