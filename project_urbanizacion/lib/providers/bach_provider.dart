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
  String nameImg1 = "";
  String nameImg2 = "";
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
      String opt = "";
      if (isBloque) {
        opt = await api.postinsertGc0032LOT(Gc0032LOT(
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
            vtiLot: "$nameImg1/$nameImg2",
            gpsLot: ubi,
            stsLot: "A"));
      } else {
        bool resp = await api.putGc0032Lot(Gc0032LOT(
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
            vtiLot: "$uid$nameImg1/$uid$nameImg2",
            gpsLot: ubi,
            stsLot: "A"));
        if (resp) {
          opt = "200";
        } else {
          opt = "400";
        }
      }

      if (opt.contains("200")) {
        saveImg(uid);
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
        nameImg1 = "_${idATxtController.text}_1.${file.extension!}";
      } else {
        listImg2 = file.bytes!;
        nameImg2 = "_${idATxtController.text}_2.${file.extension!}";
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
      api.uploadImg(base64.encode(listImg1!), "$uid$nameImg1");
      listImg1 = null;
      nameImg1 = "";
    }
    if (listImg2 != null) {
      api.uploadImg(base64.encode(listImg2!), "$uid$nameImg2");
      listImg2 = null;
      nameImg2 = "";
    }
  }

  Future getObtenerImgs(String value) async {
    List<String> list = value.split("/");
    String opt = "";
    int i = 0;
    for (var e in list) {
      if (i == 0) {
        opt = await api.downloadBase64Info(e);
        if (opt != "") {
          listImg1 = base64.decode(opt);
        }
      } else {
        opt = await api.downloadBase64Info(e);
        if (opt != "") {
          listImg2 = base64.decode(opt);
        }
      }
      i++;
    }
  }
}
