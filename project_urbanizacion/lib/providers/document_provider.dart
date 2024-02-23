import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/model/gc0032Lot.dart';
import 'package:project_urbanizacion/model/gc0040.dart';
import 'package:project_urbanizacion/utils/constantes.dart';
import 'package:project_urbanizacion/utils/create_file_web.dart';
import 'package:project_urbanizacion/utils/util_view.dart';

class DocumentProvider extends ChangeNotifier {
  final api = SolicitudApi();
  Gc0032LOT? obj;
  Gc0032? habitante;
  List<Gc0032LOT> listObj = [];
  bool isBloque = true;
  final idDocTxtController = TextEditingController();
  Future<bool> saveReferencia(
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
      var objeto = Gc0040(
          codEmp: Constantes.selectEmpresa.codEmp,
          numDup: idDocTxtController.text,
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
          stsLot: "A");
      String opt = await api.postinsertGc0040(objeto);
      if (opt.contains("200")) {
        await CreateFileWeb.onStarPdf(objeto, habitante!.nomNic);
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

  Future<bool> getLoteList(String cedula) async {
    habitante = await api.getHabitante(cedula);
    listObj = await api.getListGc0032LOT(cedula);
    return listObj.isNotEmpty;
  }

  showViewEvent() {
    isBloque = !isBloque;
    notifyListeners();
  }

  Future getObtenerTicket() async {
    String? resp = await api.getMaxNumDup();
    idDocTxtController.text = UtilView.getSecuenceString(resp ?? "0", 6);
  }
}
