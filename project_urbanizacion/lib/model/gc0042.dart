import 'dart:convert';

class Gc0042 {
  String codEmp;
  String clsTul;
  String numTul;
  DateTime fecTul;
  String secNic;
  int ntaLot;
  int ntrLot;
  String auxNic;
  String ucrLot;
  DateTime fcrLot;
  String umdLot;
  DateTime fmdLot;
  String obsLot;
  String fpgLot;
  String epgLot;
  String opgLot;
  double vpgLot;
  String stsLot;

  Gc0042({
    required this.codEmp,
    required this.clsTul,
    required this.numTul,
    required this.fecTul,
    required this.secNic,
    required this.ntaLot,
    required this.ntrLot,
    required this.auxNic,
    required this.ucrLot,
    required this.fcrLot,
    required this.umdLot,
    required this.fmdLot,
    required this.obsLot,
    required this.fpgLot,
    required this.epgLot,
    required this.opgLot,
    required this.vpgLot,
    required this.stsLot,
  });

  factory Gc0042.fromJson(String str) => Gc0042.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gc0042.fromMap(Map<String, dynamic> json) => Gc0042(
        codEmp: json["codEmp"],
        clsTul: json["clsTul"],
        numTul: json["numTul"],
        fecTul: json["fecTul"],
        secNic: json["secNic"],
        ntaLot: json["ntaLot"],
        ntrLot: json["ntrLot"],
        auxNic: json["auxNic"],
        ucrLot: json["ucrLot"],
        fcrLot: json["fcrLot"],
        umdLot: json["umdLot"],
        fmdLot: json["fmdLot"],
        obsLot: json["obsLot"],
        fpgLot: json["fpgLot"],
        epgLot: json["epgLot"],
        opgLot: json["opgLot"],
        vpgLot: json["vpgLot"],
        stsLot: json["stsLot"],
      );

  Map<String, dynamic> toMap() => {
        "codEmp": codEmp,
        "clsTul": clsTul,
        "numTul": numTul,
        "fecTul": fecTul.toIso8601String(),
        "secNic": secNic,
        "ntaLot": ntaLot,
        "ntrLot": ntrLot,
        "auxNic": auxNic,
        "ucrLot": ucrLot,
        "fcrLot": fcrLot.toIso8601String(),
        "umdLot": umdLot,
        "fmdLot": fmdLot.toIso8601String(),
        "obsLot": obsLot,
        "fpgLot": fpgLot,
        "epgLot": epgLot,
        "opgLot": opgLot,
        "vpgLot": vpgLot,
        "stsLot": stsLot,
      };
}
