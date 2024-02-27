import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0020Cob.dart';
import 'package:project_urbanizacion/utils/constantes.dart';
import 'package:project_urbanizacion/utils/util_view.dart';

class CollectionProvider extends ChangeNotifier {
  final api = SolicitudApi();
  Gc0020Cob? obj;

  Future<bool> saveReferencia(
      String fecMax, int codeMot, String observacion, String valor) async {
    try {
      String opt = await api.postinsertGc0020Cob(Gc0020Cob(
          codEmp: Constantes.selectEmpresa.codEmp,
          secNic: "",
          codPto: "001001",
          codMov: "CC",
          numMov: "",
          ptoRel: "",
          codRel: "",
          numRel: "",
          fecEmi: DateTime.now(),
          fecVen: UtilView.convertStringToDate(fecMax),
          valMov: double.parse(valor),
          sdoMov: double.parse(valor),
          codCob: "XXXX",
          codBco: "$codeMot",
          numCta: "",
          nunCta: "",
          girador: UtilView.tpMotivo[codeMot]!,
          obsMov: observacion,
          ptoNex: "",
          codNex: "",
          numNex: "",
          fecNex: DateTime.now(),
          fcrNex: DateTime.now(),
          ncrNex: "",
          acrNex: "",
          valNex: 0,
          stsNex: "",
          codWmw: "",
          numWmw: "",
          fecWmw: DateTime.now(),
          codDiv: "",
          cotDiv: 0,
          scsMov: "",
          sosMov: "",
          stsMov: "A"));

      if (opt.contains("200")) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //print("Error al guardar la referencia");
      return false;
    }
  }
}
