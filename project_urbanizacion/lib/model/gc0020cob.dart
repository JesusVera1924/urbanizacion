import 'dart:convert';

class Gc0020Cob {
  String codEmp;
  String secNic;
  String codPto;
  String codMov;
  String numMov;
  String ptoRel;
  String codRel;
  String numRel;
  DateTime fecEmi;
  DateTime fecVen;
  double valMov;
  double sdoMov;
  String codCob;
  String codBco;
  String numCta;
  String nunCta;
  String girador;
  String obsMov;
  String ptoNex;
  String codNex;
  String numNex;
  dynamic fecNex;
  DateTime fcrNex;
  String ncrNex;
  String acrNex;
  double valNex;
  String stsNex;
  String codWmw;
  String numWmw;
  dynamic fecWmw;
  String codDiv;
  double cotDiv;
  String scsMov;
  String sosMov;
  String stsMov;

  Gc0020Cob({
    required this.codEmp,
    required this.secNic,
    required this.codPto,
    required this.codMov,
    required this.numMov,
    required this.ptoRel,
    required this.codRel,
    required this.numRel,
    required this.fecEmi,
    required this.fecVen,
    required this.valMov,
    required this.sdoMov,
    required this.codCob,
    required this.codBco,
    required this.numCta,
    required this.nunCta,
    required this.girador,
    required this.obsMov,
    required this.ptoNex,
    required this.codNex,
    required this.numNex,
    required this.fecNex,
    required this.fcrNex,
    required this.ncrNex,
    required this.acrNex,
    required this.valNex,
    required this.stsNex,
    required this.codWmw,
    required this.numWmw,
    required this.fecWmw,
    required this.codDiv,
    required this.cotDiv,
    required this.scsMov,
    required this.sosMov,
    required this.stsMov,
  });

  factory Gc0020Cob.fromJson(String str) => Gc0020Cob.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gc0020Cob.fromMap(Map<String, dynamic> json) => Gc0020Cob(
        codEmp: json["cod_emp"],
        secNic: json["sec_nic"],
        codPto: json["cod_pto"],
        codMov: json["cod_mov"],
        numMov: json["num_mov"],
        ptoRel: json["pto_rel"],
        codRel: json["cod_rel"],
        numRel: json["num_rel"],
        fecEmi: DateTime.parse(json["fec_emi"]),
        fecVen: DateTime.parse(json["fec_ven"]),
        valMov: json["val_mov"]?.toDouble(),
        sdoMov: json["sdo_mov"]?.toDouble(),
        codCob: json["cod_cob"],
        codBco: json["cod_bco"],
        numCta: json["num_cta"],
        nunCta: json["nun_cta"],
        girador: json["girador"],
        obsMov: json["obs_mov"],
        ptoNex: json["pto_nex"],
        codNex: json["cod_nex"],
        numNex: json["num_nex"],
        fecNex: json["fec_nex"] != null
            ? DateTime.parse(json["fec_nex"])
            : DateTime.now(),
        fcrNex: json["fcr_nex"] != null
            ? DateTime.parse(json["fcr_nex"])
            : DateTime.now(),
        ncrNex: json["ncr_nex"],
        acrNex: json["acr_nex"],
        valNex: json["val_nex"]?.toDouble(),
        stsNex: json["sts_nex"],
        codWmw: json["cod_wmw"],
        numWmw: json["num_wmw"],
        fecWmw: json["fec_wmw"] != null
            ? DateTime.parse(json["fec_wmw"])
            : DateTime.now(),
        codDiv: json["cod_div"],
        cotDiv: json["cot_div"]?.toDouble(),
        scsMov: json["scs_mov"],
        sosMov: json["sos_mov"],
        stsMov: json["sts_mov"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "sec_nic": secNic,
        "cod_pto": codPto,
        "cod_mov": codMov,
        "num_mov": numMov,
        "pto_rel": ptoRel,
        "cod_rel": codRel,
        "num_rel": numRel,
        "fec_emi":
            "${fecEmi.year.toString().padLeft(4, '0')}-${fecEmi.month.toString().padLeft(2, '0')}-${fecEmi.day.toString().padLeft(2, '0')}",
        "fec_ven":
            "${fecVen.year.toString().padLeft(4, '0')}-${fecVen.month.toString().padLeft(2, '0')}-${fecVen.day.toString().padLeft(2, '0')}",
        "val_mov": valMov,
        "sdo_mov": sdoMov,
        "cod_cob": codCob,
        "cod_bco": codBco,
        "num_cta:": numCta,
        "nun_cta": nunCta,
        "girador": girador,
        "obs_mov": obsMov,
        "pto_nex": ptoNex,
        "cod_nex": codNex,
        "num_nex": numNex,
        "fec_nex":
            "${fecNex.year.toString().padLeft(4, '0')}-${fecNex.month.toString().padLeft(2, '0')}-${fecNex.day.toString().padLeft(2, '0')}",
        "fcr_nex":
            "${fcrNex.year.toString().padLeft(4, '0')}-${fcrNex.month.toString().padLeft(2, '0')}-${fcrNex.day.toString().padLeft(2, '0')}",
        "ncr_nex": ncrNex,
        "acr_nex": acrNex,
        "val_nex": valNex,
        "sts_nex": stsNex,
        "cod_wmw": codWmw,
        "num_wmw": numWmw,
        "fec_wmw":
            "${fecWmw.year.toString().padLeft(4, '0')}-${fecWmw.month.toString().padLeft(2, '0')}-${fecWmw.day.toString().padLeft(2, '0')}",
        "cod_div": codDiv,
        "cot_div": cotDiv,
        "scs_mov": scsMov,
        "sos_mov": sosMov,
        "sts_mov": stsMov,
      };
}
