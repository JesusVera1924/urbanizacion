import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0032Lot.dart';
import 'package:project_urbanizacion/model/gc0042.dart';
import 'package:project_urbanizacion/utils/constantes.dart';
import 'package:project_urbanizacion/utils/util_view.dart';

class PossessionProvider extends ChangeNotifier {
  final api = SolicitudApi();
  Gc0032LOT? obj;
  final numeroTxtController = TextEditingController();
  bool isBloque = true;

  Future<bool> saveReferencia(
      String clsTul,
      String fecTul,
      String secNic,
      String ntaLot,
      String ntrLot,
      String auxNic,
      String obsLot,
      String fpgLot,
      String epgLot,
      String opgLot,
      String vpgLot) async {
    try {
      String opt = await api.postinsertGc0042(Gc0042(
          codEmp: Constantes.selectEmpresa.codEmp,
          clsTul: clsTul,
          numTul: numeroTxtController.text,
          fecTul: UtilView.convertStringToDate(fecTul),
          secNic: secNic,
          ntaLot: int.parse(ntaLot),
          ntrLot: int.parse(ntrLot),
          auxNic: auxNic,
          ucrLot: "XXXX",
          fcrLot: DateTime.now(),
          umdLot: "",
          fmdLot: DateTime.now(),
          obsLot: obsLot,
          fpgLot: fpgLot,
          epgLot: epgLot,
          opgLot: opgLot,
          vpgLot: double.parse(vpgLot),
          stsLot: "A"));

      if (opt.contains("200")) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error al guardar la referencia");
      return false;
    }
  }

  Future<bool> getLote(String cedula) async {
    obj = await api.getGc0032LOT(cedula);
    return obj != null;
  }

  showViewEvent() {
    isBloque = !isBloque;
    notifyListeners();
  }

  Future getObtenerTicket() async {
    String? resp = await api.getMaxNumTul();
    numeroTxtController.text = UtilView.getSecuenceString(resp ?? "0", 6);
  }
}
