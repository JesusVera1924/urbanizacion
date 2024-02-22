import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0001.dart';
import 'package:project_urbanizacion/model/gc0002.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/utils/constantes.dart';

class OrganizationProvider extends ChangeNotifier {
  final api = SolicitudApi();

  Gc0001? empresaActual;
  Gc0001? objeto;

  List<String> list = [];
  //controladores de caja de textos
  final idETxtController = TextEditingController();
  final idTxtController = TextEditingController();
  final nombreTxtController = TextEditingController();
  final representanteTxtController = TextEditingController();
  final direccionTxtController = TextEditingController();
  final celularTxtController = TextEditingController();
  final correoTxtController = TextEditingController();

  Future<String?> saveComite() async {
    String resp = "";
    int i = 0;

    Gc0001 objeto = Gc0001(
        codEmp: idETxtController.text,
        nomEmp: nombreTxtController.text,
        dirEmp: direccionTxtController.text,
        tmvEmp: celularTxtController.text,
        bznEmp: correoTxtController.text,
        nicEmp: idTxtController.text,
        drlEmp: representanteTxtController.text,
        na1Emp: "",
        na2Emp: "",
        na3Emp: "",
        na4Emp: "",
        na5Emp: "",
        stsEmp: "A");

    for (var s in list) {
      if (i == 0) {
        objeto.na1Emp = s;
      } else if (i == 1) {
        objeto.na2Emp = s;
      } else if (i == 2) {
        objeto.na3Emp = s;
      } else if (i == 3) {
        objeto.na4Emp = s;
      } else if (i == 4) {
        objeto.na5Emp = s;
      }
      i++;
    }

    String opt = await api.postinsertGc0001(objeto);

    if (opt.contains("200")) {
      nombreTxtController.clear();
      direccionTxtController.clear();
      celularTxtController.clear();
      correoTxtController.clear();
      idTxtController.clear();
      representanteTxtController.clear();
      list.clear();
      resp = "Peticion Exitosa";
      notifyListeners();
    } else {
      resp = "Error en la peticion";
    }

    return resp;
  }

  Future<String?> updateComite() async {
    String resp = "";
    int i = 0;

    Gc0001 g = Gc0001(
        codEmp: Constantes.selectEmpresa.codEmp,
        nomEmp: Constantes.selectEmpresa.nomEmp,
        dirEmp: direccionTxtController.text,
        tmvEmp: celularTxtController.text,
        bznEmp: correoTxtController.text,
        nicEmp: idTxtController.text,
        drlEmp: representanteTxtController.text,
        na1Emp: "",
        na2Emp: "",
        na3Emp: "",
        na4Emp: "",
        na5Emp: "",
        stsEmp: "A");

    for (var s in list) {
      if (i == 0) {
        g.na1Emp = s;
      } else if (i == 1) {
        g.na2Emp = s;
      } else if (i == 2) {
        g.na3Emp = s;
      } else if (i == 3) {
        g.na4Emp = s;
      } else if (i == 4) {
        g.na5Emp = s;
      }
      i++;
    }

    bool opt = await api.putGc0001(g);

    if (opt) {
      resp = "Peticion Exitosa";
    } else {
      resp = "Error en la peticion";
    }

    return resp;
  }

  Future<String> savePeriodo(String periodo, String cicEmp) async {
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
    list.add(obj.nomNic);
    notifyListeners();
  }

  eliminarObjList(int i) {
    list.remove(list[i]);
    notifyListeners();
  }

  Future<void> getRequestData() async {
    await obtenerCommitte();
    notifyListeners();
  }

  Future obtenerCommitte() async {
    empresaActual = await api.getGc0001CodEmp(Constantes.selectEmpresa.codEmp);
    list.clear();
    if (empresaActual != null) {
      nombreTxtController.text = empresaActual!.nomEmp;
      idTxtController.text = empresaActual!.nicEmp;
      direccionTxtController.text = empresaActual!.dirEmp;
      correoTxtController.text = empresaActual!.bznEmp;
      celularTxtController.text = empresaActual!.tmvEmp;
      representanteTxtController.text = empresaActual!.drlEmp;

      if (empresaActual!.na1Emp != "") {
        list.add(empresaActual!.na1Emp);
      }
      if (empresaActual!.na2Emp != "") {
        list.add(empresaActual!.na2Emp);
      }
      if (empresaActual!.na3Emp != "") {
        list.add(empresaActual!.na3Emp);
      }
      if (empresaActual!.na4Emp != "") {
        list.add(empresaActual!.na4Emp);
      }
      if (empresaActual!.na5Emp != "") {
        list.add(empresaActual!.na5Emp);
      }
    }
  }
}
