import 'dart:convert';

import 'package:project_urbanizacion/model/gc0001.dart';
import 'package:project_urbanizacion/model/usuario.dart';

class Authentication {
  Usuario usuario;
  String token;
  List<Gc0001> empresa;

  Authentication({
    required this.usuario,
    required this.token,
    required this.empresa,
  });

  factory Authentication.fromJson(String str) =>
      Authentication.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Authentication.fromMap(Map<String, dynamic> json) => Authentication(
        usuario: Usuario.fromMap(json["usuario"]),
        token: json["token"],
        empresa:
            List<Gc0001>.from(json["empresa"].map((x) => Gc0001.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "usuario": usuario.toMap(),
        "token": token,
        "empresa": List<dynamic>.from(empresa.map((x) => x.toMap())),
      };
}
