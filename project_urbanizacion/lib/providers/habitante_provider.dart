import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/model/gc0032a.dart';
import 'package:project_urbanizacion/model/gc0032c.dart';
import 'package:project_urbanizacion/utils/constantes.dart';
import 'package:project_urbanizacion/utils/util_view.dart';

class HabitanteProvider extends ChangeNotifier {
  final api = SolicitudApi();

  Gc0032? selectHabitante;
  List<Gc0032> listHabitantes = [];
  List<Gc0032A> listRef = [];
  List<Gc0032C> listRefFamiliares = [];

  //Condiciones
  bool isUpdate = false;
  bool isView = true;

  //controladores del primer dialogo ref
  final txtIdentificacion = TextEditingController();
  final txtNombre = TextEditingController();
  int selectDni = 1;
  int selectSexo = 1;
  final txtFecha = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));

  //controladores del segundo dialogo ref
  final txtIdentificacion2 = TextEditingController();
  final txtNombre2 = TextEditingController();
  final txtTelefono = TextEditingController();
  final txtCorreo = TextEditingController();
  final txtVinculo = TextEditingController();

  //imagen
  String nameImg1 = "";
  Uint8List? listImg1;
  //metodos

  Future<String?> updateHabitante(int tpI, String numero, String name, int tpS,
      String fecha, String telefono, String email, int tpC, String obs) async {
    String? resp;

    bool? opt = await api.putGc0032(Gc0032(
        codEmp: Constantes.selectEmpresa.codEmp,
        clsNic: "$tpI",
        secNic: numero,
        nomNic: name,
        segNic: "",
        cicNic: "$tpC",
        sexNic: "$tpS",
        obsNic: obs,
        fNNic: UtilView.convertStringToDate(fecha),
        tmvNic: telefono,
        bznNic: email,
        iqrNic: "",
        fqrNic: DateTime.now(),
        ucrNic: "XXXX",
        fcrNic: DateTime.now(),
        umdNic: "",
        fmdNic: DateTime.now(),
        stsNic: "A"));

    if (opt) {
      await api.putGc0032A(listRef);
      await api.putGc0032C(listRefFamiliares);
      resp = "GUARDADO CON EXITO";
    }

    return resp;
  }

  Future<String?> saveHabitante(int tpI, String numero, String name, int tpS,
      String telefono, String email, int tpC, String obs) async {
    String resp = "";

    String? opt = await api.postGc0032(Gc0032(
        codEmp: Constantes.selectEmpresa.codEmp,
        clsNic: "$tpI",
        secNic: numero,
        nomNic: name,
        segNic: "",
        cicNic: "$tpC",
        sexNic: "$tpS",
        obsNic: obs,
        fNNic: DateTime.now(),
        tmvNic: telefono,
        bznNic: email,
        iqrNic: "",
        fqrNic: DateTime.now(),
        ucrNic: "XXXX",
        fcrNic: DateTime.now(),
        umdNic: "",
        fmdNic: DateTime.now(),
        stsNic: "A"));

    if (opt!.contains("200")) {
      for (var e in listRef) {
        e.secNic = numero;
      }

      for (var e in listRefFamiliares) {
        e.secNic = numero;
      }

      await api.postinsertGc0032A(listRef);
      await api.postinsertGc0032C(listRefFamiliares);
    }

    return resp;
  }

  addReferencia() async {
    listRef.add(Gc0032A(
        codEmp: Constantes.selectEmpresa.codEmp,
        secNic: "",
        secRdh: txtIdentificacion.text,
        nomRdh: txtNombre.text,
        sexRdh: "$selectSexo",
        fncRdh: UtilView.convertStringToDate(txtFecha.text),
        clsRdh: "$selectDni",
        stsRdh: "I"));
    notifyListeners();
  }

  addReferenciaFamiliar() async {
    listRefFamiliares.add(Gc0032C(
        codEmp: "01",
        secNic: "",
        secIru: txtIdentificacion2.text,
        nomIru: txtNombre2.text,
        tmvIru: txtTelefono.text,
        bznIru: txtCorreo.text,
        vinIru: txtVinculo.text,
        stsIru: "I"));
    clearValDialog();
  }

  actualizarView() {
    isView = !isView;
    notifyListeners();
  }

  deleteRegistro(Gc0032A value) {
    listRef.remove(value);
    notifyListeners();
  }

  deleteRegistroFamiliares(Gc0032C value) {
    listRefFamiliares.remove(value);
    notifyListeners();
  }

  updateRegistroFamiliares(Gc0032C value) {
    notifyListeners();
  }

  Future<List<Gc0032>> getAllSearch(String value) async {
    List<Gc0032> items = await api.getHabitantes(value);
    return items;
  }

  Future getReferencias(String value) async {
    listRef = await api.getReferencia1(value);
    listRefFamiliares = await api.getReferencia2(value);
    notifyListeners();
  }

  clearVal() {
    listHabitantes.clear();
    listRef.clear();
    listRefFamiliares.clear();
    notifyListeners();
  }

  clearValDialog() {
    //controladores del primer dialogo ref
    txtIdentificacion.clear();
    txtNombre.clear();
    selectDni = 1;
    selectSexo = 1;
    txtFecha.clear();
    txtIdentificacion2.clear();
    txtNombre2.clear();
    txtTelefono.clear();
    txtCorreo.clear();
    txtVinculo.clear();
    isUpdate = false;
    notifyListeners();
  }

  Future<String> deleteHabitante(Gc0032 c) async {
    return await api.deleteHabitante(c.secNic.trim());
  }

  Future<List<Gc0032>> getRequestData(String query) async {
    return await getAllSearch(query);
  }

  Future openFileExplorer(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', "jpg", "jpeg"]);

    if (result != null) {
      PlatformFile file = result.files.first;

      listImg1 = file.bytes!;
      nameImg1 = file.extension!;
    }
    notifyListeners();
  }

  limpiarImagen() {
    listImg1 = null;
    notifyListeners();
  }
}
