import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0001.dart';
import 'package:project_urbanizacion/model/gc0002.dart';
import 'package:project_urbanizacion/model/gc0032.dart';

class CommitteProvider extends ChangeNotifier {
  final api = SolicitudApi();

  Gc0001? objeto;
  List<Gc0032> list = [];
  List<String> listComitte = [];

  Future<String?> saveComite(String nomEmp, String dirEmp, String tmvEmp,
      String bznEmp, String nicEmp, String drlEmp, List<Gc0032> list) async {
    String resp = "";
    int i = 0;

    Gc0001 objeto = Gc0001(
        codEmp: "01",
        nomEmp: nomEmp,
        dirEmp: dirEmp,
        tmvEmp: tmvEmp,
        bznEmp: bznEmp,
        nicEmp: nicEmp,
        drlEmp: drlEmp,
        na1Emp: "",
        na2Emp: "",
        na3Emp: "",
        na4Emp: "",
        na5Emp: "",
        stsEmp: "A");

    for (var s in list) {
      if (i == 0) {
        objeto.na1Emp = s.nomNic;
      } else if (i == 1) {
        objeto.na2Emp = s.nomNic;
      } else if (i == 2) {
        objeto.na3Emp = s.nomNic;
      } else if (i == 3) {
        objeto.na4Emp = s.nomNic;
      } else if (i == 4) {
        objeto.na5Emp = s.nomNic;
      }
      i++;
    }

    String opt = await api.postinsertGc0001(objeto);

    if (opt.contains("200")) {
      resp = "Peticion Exitosa";
    } else {
      resp = "Error en la peticion";
    }
    list.clear();

    return resp;
  }

  Future<String?> savePeriodo(String periodo, String cicEmp) async {
    String resp = "";

    if (objeto != null) {
      Gc0002 gc002 = Gc0002(
          codEmp: "01",
          periodo: periodo,
          cicEmp: cicEmp,
          na1Emp: objeto!.na1Emp,
          na2Emp: objeto!.na2Emp,
          na3Emp: objeto!.na3Emp,
          na4Emp: objeto!.na4Emp,
          na5Emp: objeto!.na5Emp,
          stsEmp: "A");

      String opt = await api.postinsertGc0002(gc002);

      if (opt.contains("200")) {
        resp = "Peticion Exitosa";
      } else {
        resp = "Error en la peticion";
      }
    }

    return resp;
  }

  agregarObjList(Gc0032 obj) {
    list.add(obj);
    notifyListeners();
  }

  eliminarObjList(int i) {
    list.remove(list[i]);
    notifyListeners();
  }

  Future<void> getRequestData() async {
    listComitte.clear();
    objeto = await api.getGc0001();
    if (objeto != null) {
      if (objeto!.na1Emp != "") {
        listComitte.add("1 ${objeto!.na1Emp}");
      }
      if (objeto!.na2Emp != "") {
        listComitte.add("2 ${objeto!.na2Emp}");
      }
      if (objeto!.na3Emp != "") {
        listComitte.add("3 ${objeto!.na3Emp}");
      }
      if (objeto!.na4Emp != "") {
        listComitte.add("4 ${objeto!.na4Emp}");
      }
      if (objeto!.na5Emp != "") {
        listComitte.add("5 ${objeto!.na5Emp}");
      }
    }
    notifyListeners();
  }

}
