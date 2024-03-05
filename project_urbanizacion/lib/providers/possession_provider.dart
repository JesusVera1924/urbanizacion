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
  bool isActualizar = false;

  //controladores
  final mdmNTxtController = TextEditingController();
  final dirNTxtController = TextEditingController();
  final mdmSTxtController = TextEditingController();
  final dirSTxtController = TextEditingController();
  final mdmETxtController = TextEditingController();
  final dirETxtController = TextEditingController();
  final mdmOTxtController = TextEditingController();
  final dirOTxtController = TextEditingController();
  final idRTxtController = TextEditingController();
  final idATxtController = TextEditingController();
  final barrioTxtController = TextEditingController();
  final coordenadaTxtController = TextEditingController();

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
      //print("Error al guardar la referencia");
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

  Future getObtenerInfLot(String uid) async {
    obj = await api.getGc0032LOTID(uid);
    if (obj != null) {
      mdmNTxtController.text = "${obj!.mtnLot}";
      dirNTxtController.text = obj!.dtnLot;
      mdmSTxtController.text = "${obj!.mtsLot}";
      dirSTxtController.text = obj!.dtsLot;

      mdmETxtController.text = "${obj!.mteLot}";
      dirETxtController.text = obj!.dteLot;
      mdmOTxtController.text = "${obj!.mtoLot}";
      dirOTxtController.text = obj!.dtoLot;

      idATxtController.text = "${obj!.ntaLot}";
      idRTxtController.text = "${obj!.ntrLot}";
      barrioTxtController.text = obj!.bosLot;
      coordenadaTxtController.text = obj!.gpsLot;
      isActualizar = true;
    }
    notifyListeners();
  }

  Future getObtenerTicketLot() async {
    String? resp = await api.getMaxNtaLot();
    idATxtController.text = UtilView.getSecuenceString(resp ?? "0", 6);
  }

  Future<bool> saveReferenciaLot(String cedula) async {
    try {
      String opt = await api.postinsertGc0032LOT(Gc0032LOT(
          codEmp: Constantes.selectEmpresa.codEmp,
          secNic: cedula,
          mtnLot: double.parse(mdmNTxtController.text),
          dtnLot: dirNTxtController.text,
          mtsLot: double.parse(mdmSTxtController.text),
          dtsLot: dirSTxtController.text,
          mteLot: double.parse(mdmETxtController.text),
          dteLot: dirETxtController.text,
          mtoLot: double.parse(mdmOTxtController.text),
          dtoLot: dirOTxtController.text,
          ntaLot: int.parse(idATxtController.text),
          ntrLot: int.parse(idRTxtController.text),
          bosLot: barrioTxtController.text,
          vtiLot: "",
          gpsLot: coordenadaTxtController.text,
          stsLot: "A"));
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

  clearValue() {
    mdmNTxtController.clear();
    dirNTxtController.clear();
    mdmSTxtController.clear();
    dirSTxtController.clear();
    mdmETxtController.clear();
    dirETxtController.clear();
    mdmOTxtController.clear();
    dirOTxtController.clear();
    idATxtController.clear();
    idRTxtController.clear();
    barrioTxtController.clear();
    coordenadaTxtController.clear();
    obj = null;
  }
}
