import 'dart:convert';

class Gc0032LOT {
  String codEmp;
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
  String bosLot;
  String vtiLot;
  String gpsLot;
  String stsLot;

  Gc0032LOT({
    required this.codEmp,
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
    required this.bosLot,
    required this.vtiLot,
    required this.gpsLot,
    required this.stsLot,
  });

  factory Gc0032LOT.fromJson(String str) => Gc0032LOT.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gc0032LOT.fromMap(Map<String, dynamic> json) => Gc0032LOT(
        codEmp: json["codEmp"],
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
        bosLot: json["bosLot"],
        vtiLot: json["vtiLot"],
        gpsLot: json["gpsLot"],
        stsLot: json["stsLot"],
      );

  Map<String, dynamic> toMap() => {
        "codEmp": codEmp,
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
        "bosLot": bosLot,
        "vtiLot": vtiLot,
        "gpsLot": gpsLot,
        "stsLot": stsLot,
      };
}
