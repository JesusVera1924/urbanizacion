import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0032Lot.dart';
import 'package:project_urbanizacion/model/gc0040.dart';
import 'package:project_urbanizacion/utils/util_view.dart';

class DocumentProvider extends ChangeNotifier {
  final api = SolicitudApi();
  Gc0032LOT? obj;
  bool isBloque = true;
  Future<bool> saveReferencia(
      String numDup,
      String fecDup,
      String secNic,
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
      String ob1Lot,
      String fpgLot,
      String epgLot,
      String opgLot,
      String vpgLot) async {
    try {
      String opt = await api.postinsertGc0040(Gc0040(
          codEmp: "01",
          numDup: numDup,
          fecDup: UtilView.convertStringToDate(fecDup),
          secNic: secNic,
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
          ucrLot: "XXXX",
          fcrLot: DateTime.now(),
          umdLot: "",
          fmdLot: DateTime.now(),
          ob1Lot: ob1Lot,
          ob2Lot: "",
          ob3Lot: "",
          ob4Lot: "",
          ob5Lot: "",
          st1Lot: "A",
          st2Lot: "",
          st3Lot: "",
          st4Lot: "",
          st5Lot: "",
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
}
