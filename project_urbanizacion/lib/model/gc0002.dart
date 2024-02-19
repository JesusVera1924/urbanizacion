import 'dart:convert';

class Gc0002 {
  String codEmp;
  String periodo;
  String cicEmp;
  String na1Emp;
  String na2Emp;
  String na3Emp;
  String na4Emp;
  String na5Emp;
  String stsEmp;

  Gc0002({
    required this.codEmp,
    required this.periodo,
    required this.cicEmp,
    required this.na1Emp,
    required this.na2Emp,
    required this.na3Emp,
    required this.na4Emp,
    required this.na5Emp,
    required this.stsEmp,
  });

  factory Gc0002.fromJson(String str) => Gc0002.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gc0002.fromMap(Map<String, dynamic> json) => Gc0002(
        codEmp: json["codEmp"],
        periodo: json["periodo"],
        cicEmp: json["cicEmp"],
        na1Emp: json["na1Emp"],
        na2Emp: json["na2Emp"],
        na3Emp: json["na3Emp"],
        na4Emp: json["na4Emp"],
        na5Emp: json["na5Emp"],
        stsEmp: json["stsRdh"],
      );

  Map<String, dynamic> toMap() => {
        "codEmp": codEmp,
        "periodo": periodo,
        "cicEmp": cicEmp,
        "na1Emp": na1Emp,
        "na2Emp": na2Emp,
        "na3Emp": na3Emp,
        "na4Emp": na4Emp,
        "na5Emp": na5Emp,
        "stsEmp": stsEmp,
      };
}
