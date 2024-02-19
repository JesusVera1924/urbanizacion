import 'dart:convert';

class Gc0032 {
  String codEmp;
  String clsNic;
  String secNic;
  String nomNic;
  String segNic;
  String cicNic;
  String sexNic;
  String obsNic;
  DateTime fNNic;
  String tmvNic;
  String bznNic;
  String iqrNic;
  DateTime fqrNic;
  String ucrNic;
  DateTime fcrNic;
  String umdNic;
  DateTime fmdNic;
  String stsNic;

  Gc0032({
    required this.codEmp,
    required this.clsNic,
    required this.secNic,
    required this.nomNic,
    required this.segNic,
    required this.cicNic,
    required this.sexNic,
    required this.obsNic,
    required this.fNNic,
    required this.tmvNic,
    required this.bznNic,
    required this.iqrNic,
    required this.fqrNic,
    required this.ucrNic,
    required this.fcrNic,
    required this.umdNic,
    required this.fmdNic,
    required this.stsNic,
  });

  factory Gc0032.fromJson(String str) => Gc0032.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gc0032.fromMap(Map<String, dynamic> json) => Gc0032(
        codEmp: json["codEmp"],
        clsNic: json["clsNic"],
        secNic: json["secNic"],
        nomNic: json["nomNic"],
        segNic: json["segNic"],
        cicNic: json["cicNic"],
        sexNic: json["sexNic"],
        obsNic: json["obsNic"],
        fNNic: DateTime.parse(json["fnNic"]),
        tmvNic: json["tmvNic"],
        bznNic: json["bznNic"],
        iqrNic: json["iqrNic"],
        fqrNic: DateTime.parse(json["fqrNic"]),
        ucrNic: json["ucrNic"],
        fcrNic: DateTime.parse(json["fcrNic"]),
        umdNic: json["umdNic"],
        fmdNic: DateTime.parse(json["fmdNic"]),
        stsNic: json["stsNic"],
      );

  Map<String, dynamic> toMap() => {
        "codEmp": codEmp,
        "clsNic": clsNic,
        "secNic": secNic,
        "nomNic": nomNic,
        "segNic": segNic,
        "cicNic": cicNic,
        "sexNic": sexNic,
        "obsNic": obsNic,
        "fnNic":
            "${fNNic.year.toString().padLeft(4, '0')}-${fNNic.month.toString().padLeft(2, '0')}-${fNNic.day.toString().padLeft(2, '0')}",
        "tmvNic": tmvNic,
        "bznNic": bznNic,
        "iqrNic": iqrNic,
        "fqrNic": fqrNic.toIso8601String(),
        "ucrNic": ucrNic,
        "fcrNic": fcrNic.toIso8601String(),
        "umdNic": umdNic,
        "fmdNic": fmdNic.toIso8601String(),
        "stsNic": stsNic,
      };

  @override
  String toString() => "$secNic - $nomNic";
}
