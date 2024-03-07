import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/model/gc0032Lot.dart';
import 'package:project_urbanizacion/utils/constantes.dart';
import 'package:project_urbanizacion/utils/util_view.dart';

class BachProvider extends ChangeNotifier {
  final api = SolicitudApi();
  Gc0032? habitante;
  Gc0032LOT? obj;
  List<Gc0032LOT> listObj = [];
  bool isBloque = true;
  Uint8List? listImg1;
  Uint8List? listImg2;

  final idATxtController = TextEditingController();

  //--------------------------------------------------------------------------------------------

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
      String bosLot,
      String ubi) async {
    try {
      String opt = await api.postinsertGc0032LOT(Gc0032LOT(
          codEmp: Constantes.selectEmpresa.codEmp,
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
          gpsLot: ubi,
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
    String? resp = await api.getMaxNtaLot();
    idATxtController.text = UtilView.getSecuenceString(resp ?? "0", 6);
  }

  Future openFileExplorer(BuildContext context, int tp) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', "jpg", "jpeg"]);

    if (result != null) {
      PlatformFile file = result.files.first;
      if (tp == 1) {
        listImg1 = file.bytes!;
      } else {
        listImg2 = file.bytes!;
      }
    }
    notifyListeners();
  }

  limpiarImagen(int tp) {
    if (tp == 1) {
      listImg1 = null;
    } else {
      listImg2 = null;
    }
    notifyListeners();
  }

  saveImg(String uid) {
    if (listImg1 != null) {
      api.uploadImg(base64.encode(listImg1!),
          "${uid}_${idATxtController.text}${UtilView.getFirma()}");
      listImg1 = null;
    }
    if (listImg2 != null) {
      api.uploadImg(base64.encode(listImg2!),
          "${uid}_${idATxtController.text}${UtilView.getFirma()}");
      listImg2 = null;
    }
  }
}
