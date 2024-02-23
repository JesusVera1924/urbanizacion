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
    try {
      if (isValid) {
        u = await api.login(usuario, password);
      }
    } catch (e) {
      u = null;
      //print('Error en el login');
    }
    return u;
  }
}
