import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_urbanizacion/model/gc0001.dart';
import 'package:project_urbanizacion/model/gc0002.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/model/gc0032Lot.dart';
import 'package:project_urbanizacion/model/gc0032a.dart';
import 'package:project_urbanizacion/model/gc0032c.dart';
import 'package:project_urbanizacion/model/usuario.dart';

class SolicitudApi {
  static String dominio = "localhost:8080";
  static String path = "/regularizacion";

  Future<Usuario?> login(String email, String pass) async {
    var url = Uri.http(dominio, '$path/login', {'correo': email, 'pass': pass});

    try {
      //print(url);
      final respuesta = await http.post(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Usuario.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  //INSERCION DE REGISTROS

  Future<String?> postGc0032(Gc0032 objeto) async {
    var url = Uri.http(dominio, '$path/insertGc0032');

    final resquet = await http.post(url,
        body: objeto.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return utf8.decode(resquet.bodyBytes);
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> postinsertGc0032A(List<Gc0032A> lista) async {
    List<Map> bod = [];
    String cadena = '';
    var url = Uri.http(dominio, '$path/insertGc0032A');

    for (var element in lista) {
      bod.add(element.toMap());
    }
    var data = json.encode(bod);
    try {
      final respuesta = await http.post(url,
          body: data,
          headers: {"Content-type": "application/json;charset=UTF-8"});

      if (respuesta.statusCode == 200) {
        cadena = utf8.decode(respuesta.bodyBytes);
      }
    } catch (e) {
      throw ('$e');
    }
    return cadena.contains('true');
  }

  Future<bool> postinsertGc0032C(List<Gc0032C> lista) async {
    List<Map> bod = [];
    String cadena = '';
    var url = Uri.http(dominio, '$path/insertGc0032C');
    for (var element in lista) {
      bod.add(element.toMap());
    }
    var data = json.encode(bod);
    try {
      final respuesta = await http.post(url, body: data, headers: {
        "Content-type": "application/json;charset=UTF-8",
      });

      if (respuesta.statusCode == 200) {
        cadena = utf8.decode(respuesta.bodyBytes);
      }
    } catch (e) {
      throw ('$e');
    }
    return cadena.contains('true');
  }

  Future<String> postinsertGc0001(Gc0001 objeto) async {
    var url = Uri.http(dominio, '$path/insertGc0001');

    final resquet = await http.post(url,
        body: objeto.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return utf8.decode(resquet.bodyBytes);
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<String> postinsertGc0002(Gc0002 objeto) async {
    var url = Uri.http(dominio, '$path/insertGc0002');

    final resquet = await http.post(url,
        body: objeto.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return utf8.decode(resquet.bodyBytes);
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<String> postinsertGc0032LOT(Gc0032LOT objeto) async {
    var url = Uri.http(dominio, '$path/insertGc0032Lot');

    final resquet = await http.post(url,
        body: objeto.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return utf8.decode(resquet.bodyBytes);
      }
    } catch (e) {
      throw ('$e');
    }
  }

  //FIN DE LAS INSERCIONES ---------------------------------------------------------------------------------------------------------------------------

  //ACTUALIZACION DE REGISTROS

  Future<bool> putGc0032(Gc0032 datos) async {
    var url = Uri.http(dominio, '$path/updateGc0032');

    final resquet = await http.post(url,
        body: datos.toJson(),
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        String cadena = utf8.decode(resquet.bodyBytes);
        return cadena.contains('200');
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> putGc0032A(List<Gc0032A> datos) async {
    List<Map> bod = [];
    var url = Uri.http(dominio, '$path/updateGc0032A');
    for (var element in datos) {
      bod.add(element.toMap());
    }

    var data = json.encode(bod);

    final resquet = await http.post(url,
        body: data,
        headers: {"Content-type": "application/json;charset=UTF-8"});

    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        String cadena = utf8.decode(resquet.bodyBytes);
        return cadena.contains('200');
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<bool> putGc0032C(List<Gc0032C> datos) async {
    List<Map> bod = [];
    var url = Uri.http(dominio, '$path/updateGc0032C');
    for (var element in datos) {
      bod.add(element.toMap());
    }

    var data = json.encode(bod);

    final resquet = await http.post(url,
        body: data,
        headers: {"Content-type": "application/json;charset=UTF-8"});
    try {
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        String cadena = utf8.decode(resquet.bodyBytes);
        return cadena.contains('200');
      }
    } catch (e) {
      throw ('$e');
    }
  }
  // FIN DE ACTUALIZACIONES -----------------------------------------------------------------------------------------------------------------

  //OBTENER LISTAS

  Future<List<Gc0032>> getHabitantes(String value) async {
    var url = Uri.http(dominio, '$path/getSearchHabitantes', {'value': value});

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseGc0032(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Gc0032A>> getReferencia1(String value) async {
    var url = Uri.http(dominio, '$path/getHabitanteRef1', {'value': value});

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseGc0032A(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Gc0032C>> getReferencia2(String value) async {
    var url = Uri.http(dominio, '$path/getHabitanteRef2', {'value': value});

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseGc0032C(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Gc0001?> getGc0001() async {
    var url = Uri.http(dominio, '$path/getCommitte');

    try {
      //print(url);
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Gc0001.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<Gc0032LOT?> getGc0032LOT(String cedula) async {
    var url = Uri.http(dominio, '$path/getInfLote', {"value": cedula});

    try {
      //print(url);
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Gc0032LOT.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  //PARSEOS DE LISTA

  List<Gc0032> parseGc0032(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Gc0032>((json) => Gc0032.fromMap(json)).toList();
  }

  List<Gc0032A> parseGc0032A(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Gc0032A>((json) => Gc0032A.fromMap(json)).toList();
  }

  List<Gc0032C> parseGc0032C(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Gc0032C>((json) => Gc0032C.fromMap(json)).toList();
  }

  // LIST DE PARSEO ----------------------------------------------------------------------------------------------------------------------

  Future<String> deleteHabitante(String cedula) async {
    var url = Uri.http(dominio, '$path/deleteHabitante', {'cedula': cedula});

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

/* 
  Future<Gc0032?> getGc0032(String cedula) async {
    var url = Uri.http(dominio, '$path/login', {'correo': email, 'pass': pass});

    try {
      //print(url);
      final respuesta = await http.post(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Usuario.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  } */
}
