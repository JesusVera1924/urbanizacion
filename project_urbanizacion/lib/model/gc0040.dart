import 'dart:convert';

class Gc0040 {
  String codEmp;
  String numDup;
  DateTime fecDup;
  String secNic;
  double mtnLot;
  String dtnLot;
  double mtsLot;
  String dtsLot;
  double mteLot;
  String dteLot;
  double mtoLot;
  String dtoLot;
  int ntaLot;
  int ntrLot;
  String ucrLot;
  DateTime fcrLot;
  String umdLot;
  DateTime fmdLot;
  String ob1Lot;
  String ob2Lot;
  String ob3Lot;
  String ob4Lot;
  String ob5Lot;
  String st1Lot;
  String st2Lot;
  String st3Lot;
  String st4Lot;
  String st5Lot;
  String fpgLot;
  String epgLot;
  String opgLot;
  double vpgLot;
  String stsLot;

  Gc0040({
    required this.codEmp,
    required this.numDup,
    required this.fecDup,
    required this.secNic,
    required this.mtnLot,
    required this.dtnLot,
    required this.mtsLot,
    required this.dtsLot,
    required this.mteLot,
    required this.dteLot,
    required this.mtoLot,
    required this.dtoLot,
    required this.ntaLot,
    required this.ntrLot,
    required this.ucrLot,
    required this.fcrLot,
    required this.umdLot,
    required this.fmdLot,
    required this.ob1Lot,
    required this.ob2Lot,
    required this.ob3Lot,
    required this.ob4Lot,
    required this.ob5Lot,
    required this.st1Lot,
    required this.st2Lot,
    required this.st3Lot,
    required this.st4Lot,
    required this.st5Lot,
    required this.fpgLot,
    required this.epgLot,
    required this.opgLot,
    required this.vpgLot,
    required this.stsLot,
  });

  factory Gc0040.fromJson(String str) => Gc0040.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gc0040.fromMap(Map<String, dynamic> json) => Gc0040(
      codEmp: json["codEmp"],
      numDup: json["numDup"],
      fecDup:
          DateTime.parse(json["fecDup"] ?? DateTime.now().toIso8601String()),
      secNic: json["secNic"],
      mtnLot: json["mtnLot"].toDouble(),
      dtnLot: json["dtnLot"],
      mtsLot: json["mtsLot"].toDouble(),
      dtsLot: json["dtsLot"],
      mteLot: json["mteLot"].toDouble(),
      dteLot: json["dteLot"],
      mtoLot: json["mtoLot"].toDouble(),
      dtoLot: json["dtoLot"],
      ntaLot: json["ntaLot"],
      ntrLot: json["ntrLot"],
      ucrLot: json["ucrLot"],
      fcrLot:
          DateTime.parse(json["fcrLot"] ?? DateTime.now().toIso8601String()),
      umdLot: json["umdLot"],
      fmdLot:
          DateTime.parse(json["fmdLot"] ?? DateTime.now().toIso8601String()),
      ob1Lot: json["ob1Lot"],
      ob2Lot: json["ob2Lot"],
      ob3Lot: json["ob3Lot"],
      ob4Lot: json["ob4Lot"],
      ob5Lot: json["ob5Lot"],
      st1Lot: json["st1Lot"],
      st2Lot: json["st2Lot"],
      st3Lot: json["st3Lot"],
      st4Lot: json["st4Lot"],
      st5Lot: json["st5Lot"],
      fpgLot: json["fpgLot"],
      epgLot: json["epgLot"],
      opgLot: json["opgLot"],
      vpgLot: json["vpgLot"].toDouble(),
      stsLot: json["stsLot"]);

  Map<String, dynamic> toMap() => {
        "codEmp": codEmp,
        "numDup": numDup,
        "fecDup": fecDup.toIso8601String(),
        "secNic": secNic,
        "mtnLot": mtnLot,
        "dtnLot": dtnLot,
        "mtsLot": mtsLot,
        "dtsLot": dtsLot,
        "mteLot": mteLot,
        "dteLot": dteLot,
        "mtoLot": mtoLot,
        "dtoLot": dtoLot,
        "ntaLot": ntaLot,
        "ntrLot": ntrLot,
        "ucrLot": ucrLot,
        "fcrLot": fcrLot.toIso8601String(),
        "umdLot": umdLot,
        "fmdLot": fmdLot.toIso8601String(),
        "ob1Lot": ob1Lot,
        "ob2Lot": ob2Lot,
        "ob3Lot": ob3Lot,
        "ob4Lot": ob4Lot,
        "ob5Lot": ob5Lot,
        "st1Lot": st1Lot,
        "st2Lot": st2Lot,
        "st3Lot": st3Lot,
        "st4Lot": st4Lot,
        "st5Lot": st5Lot,
        "fpgLot": fpgLot,
        "epgLot": epgLot,
        "opgLot": opgLot,
        "vpgLot": vpgLot,
        "stsLot": stsLot,
      };
}
