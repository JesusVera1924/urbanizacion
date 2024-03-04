import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0020Cob.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/model/http/cobranza.dart';
import 'package:project_urbanizacion/model/http/historial.dart';

class FundraisingProvider extends ChangeNotifier {
  final api = SolicitudApi();
  //Objeto a obtener
  Gc0032? selectHabitante;
  Gc0020Cob? selectCobranza;
  //
  List<Cobranza> list = [];
  List<Historial> listHist = [];
  List<Gc0020Cob> listDet = [];

  Future getAllList() async {
    try {
      list = await api.getListCobranza();
    } catch (e) {
      //print('Error: $e');
    }
    notifyListeners();
  }

  Future getListDet(String value) async {
    try {
      listHist = await api.getAllCobranzaHist(value);

      print(listHist.length);
    } catch (e) {
      print('Error: $e');
    }
    notifyListeners();
  }

  Future<List<Gc0032>> getAllSearch(String value) async {
    List<Gc0032> items = await api.getHabitantes(value);
    return items;
  }

  Future<List<Gc0032>> getRequestData(String query) async {
    return await getAllSearch(query);
  }

  Future<bool> getCobranza(String nunmov) async {
    try {
      selectCobranza =
          await api.getCobranzaCab(nunmov, selectHabitante!.secNic);
    } catch (e) {
      print(e);
    }
    return selectCobranza != null;
  }

  Future<bool> savePass(String value) async {
    if (selectCobranza != null) {
      String opt = await api.postinsertGc0020Cobranza(selectCobranza!, value);
      if (opt.contains("200")) {
        return true;
      }
    }
    return false;
  }
}
