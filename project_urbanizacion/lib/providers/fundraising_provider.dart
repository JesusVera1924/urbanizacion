import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0020Cob.dart';
import 'package:project_urbanizacion/model/http/cobranza.dart';

class FundraisingProvider extends ChangeNotifier {
  final api = SolicitudApi();
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
}
