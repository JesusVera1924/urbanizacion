import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0032Lot.dart';

class BachProvider extends ChangeNotifier {
  final api = SolicitudApi();
  Gc0032LOT? obj;
  bool isBloque = true;
  Future<bool> saveReferencia(
      String uid,
      String mtnLot,
      String dtnLot,
      String mtsLot,
      String dtsLot,
      String mteLot,
      String dteLot,
      String mtoLot,
      String dtoLot,
      String ntaLot,
      String ntrLot,
      String bosLot) async {
    try {
      String opt = await api.postinsertGc0032LOT(Gc0032LOT(
          codEmp: "01",
          secNic: uid,
          mtnLot: double.parse(mtnLot),
          dtnLot: dtnLot,
          mtsLot: double.parse(mtsLot),
          dtsLot: dtsLot,
          mteLot: double.parse(mteLot),
          dteLot: dteLot,
          mtoLot: double.parse(mtoLot),
          dtoLot: dtoLot,
          ntaLot: int.parse(ntaLot),
          ntrLot: int.parse(ntrLot),
          bosLot: bosLot,
          vtiLot: "",
          gpsLot: "",
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
}