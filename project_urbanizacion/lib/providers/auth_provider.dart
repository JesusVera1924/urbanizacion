import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_urbanizacion/model/http/auth_response.dart';
import 'package:project_urbanizacion/router/router.dart';
import 'package:project_urbanizacion/services/local_storage.dart';
import 'package:project_urbanizacion/services/navigation_service.dart';
import 'package:project_urbanizacion/utils/constantes.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;
  Authentication? usuario;

  AuthProvider() {
    isAuthenticated();
  }

  login(Authentication u) async {
    usuario = u;
    Constantes.selectEmpresa = usuario!.empresa[0];
    LocalStorage.prefs.setString('token', "ERRORSINTOKEN");
    LocalStorage.prefs.setString('usuario', json.encode(u.toMap()));

    authStatus = AuthStatus.authenticated;
    notifyListeners();
    NavigationService.replaceTo(Flurorouter.defaulRoute);
  }

  deleteToken() async {
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    final user = LocalStorage.prefs.getString('usuario');

    if (token == null || user == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    //logica para verificar el token de llegada
    usuario = Authentication.fromMap(jsonDecode(user));
    Constantes.selectEmpresa = usuario!.empresa[0];
    await Future.delayed(const Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }

  logout() {
    LocalStorage.prefs.remove('token');
    LocalStorage.prefs.remove('usuario');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
    NavigationService.replaceTo(Flurorouter.loginRoute);
  }
}
