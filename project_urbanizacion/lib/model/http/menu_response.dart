import 'dart:convert';

class MenuResponse {
  String codPry;
  String nomPry;
  String clsPry;
  String clxPry;
  String urlPry;
  String desPry;
  String stsPry;
  String iconPry;
  String perAcc;

  MenuResponse({
    required this.codPry,
    required this.nomPry,
    required this.clsPry,
    required this.clxPry,
    required this.urlPry,
    required this.desPry,
    required this.stsPry,
    required this.iconPry,
    required this.perAcc,
  });

  factory MenuResponse.fromJson(String str) =>
      MenuResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MenuResponse.fromMap(Map<String, dynamic> json) => MenuResponse(
        codPry: json["codPry"],
        nomPry: json["nomPry"],
        clsPry: json["clsPry"],
        clxPry: json["clxPry"],
        urlPry: json["urlPry"],
        desPry: json["desPry"],
        stsPry: json["stsPry"],
        iconPry: json["iconPry"],
        perAcc: json["per_acc"],
      );

  Map<String, dynamic> toMap() => {
        "codPry": codPry,
        "nomPry": nomPry,
        "clsPry": clsPry,
        "clxPry": clxPry,
        "urlPry": urlPry,
        "desPry": desPry,
        "stsPry": stsPry,
        "iconPry": iconPry,
        "per_acc": perAcc,
      };
}
