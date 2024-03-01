import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0020Cob.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/model/http/cobranza.dart';

class FundraisingProvider extends ChangeNotifier {
  final api = SolicitudApi();
  Gc0032? selectHabitante;
  List<Cobranza> list = [];
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
      listDet = await api.getListCobranzaDet(value);
      print(listDet.length);
    } catch (e) {
      //print('Error: $e');
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
}
