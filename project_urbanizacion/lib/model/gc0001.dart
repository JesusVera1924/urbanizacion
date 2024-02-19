import 'dart:convert';

class Gc0001 {
  String codEmp;
  String nomEmp;
  String dirEmp;
  String tmvEmp;
  String bznEmp;
  String nicEmp;
  String drlEmp;
  String na1Emp;
  String na2Emp;
  String na3Emp;
  String na4Emp;
  String na5Emp;
  String stsEmp;

  Gc0001({
    required this.codEmp,
    required this.nomEmp,
    required this.dirEmp,
    required this.tmvEmp,
    required this.bznEmp,
    required this.nicEmp,
    required this.drlEmp,
    required this.na1Emp,
    required this.na2Emp,
    required this.na3Emp,
    required this.na4Emp,
    required this.na5Emp,
    required this.stsEmp,
  });

  factory Gc0001.fromJson(String str) => Gc0001.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gc0001.fromMap(Map<String, dynamic> json) => Gc0001(
        codEmp: json["codEmp"],
        nomEmp: json["nomEmp"],
        dirEmp: json["dirEmp"],
        tmvEmp: json["tmvEmp"],
        bznEmp: json["bznEmp"],
        nicEmp: json["nicEmp"],
        drlEmp: json["drlEmp"],
        na1Emp: json["na1Emp"],
        na2Emp: json["na2Emp"],
        na3Emp: json["na3Emp"],
        na4Emp: json["na4Emp"],
        na5Emp: json["na5Emp"],
        stsEmp: json["stsEmp"],
      );

  Map<String, dynamic> toMap() => {
        "codEmp": codEmp,
        "nomEmp": nomEmp,
        "dirEmp": dirEmp,
        "tmvEmp": tmvEmp,
        "bznEmp": bznEmp,
        "nicEmp": nicEmp,
        "drlEmp": drlEmp,
        "na1Emp": na1Emp,
        "na2Emp": na2Emp,
        "na3Emp": na3Emp,
        "na4Emp": na4Emp,
        "na5Emp": na5Emp,
        "stsEmp": stsEmp,
      };
}
