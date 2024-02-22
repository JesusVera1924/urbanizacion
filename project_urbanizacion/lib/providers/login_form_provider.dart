import 'package:flutter/material.dart';
import 'package:project_urbanizacion/api/solicitud_api.dart';
import 'package:project_urbanizacion/model/http/auth_response.dart';

class LoginFormProvider extends ChangeNotifier {
  final formkey = GlobalKey<FormState>();

  final api = SolicitudApi();
  String usuario = '';
  String password = '';

  bool validateForm() {
    if (formkey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<Authentication?> sendLogin() async {
    final isValid = validateForm();
    Authentication? u;
    if (isValid) {
      u = await api.login(usuario, password);
      /* u = Usuario(
          codEmp: "01",
          codPry: "01",
          codUsr: "jesusvera1924",
          nomUsr: "Jesus",
          clvUsr: "1234",
          ctaUsr: "JAVP",
          nicUsr: "0000000000",
          corUsr: "jesusvera19_24@hotmail.com",
          celUsr: "0000000000",
          rolUsr: "A",
          clsUsr: "A",
          fexUsr: DateTime.now(),
          stsUsr: "A"); */
    }
    return u;
  }
}
