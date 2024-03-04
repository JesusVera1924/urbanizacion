import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_urbanizacion/model/gc0001.dart';
import 'package:project_urbanizacion/model/gc0002.dart';
import 'package:project_urbanizacion/model/gc0020Cob.dart';
import 'package:project_urbanizacion/model/gc0032.dart';
import 'package:project_urbanizacion/model/gc0032Lot.dart';
import 'package:project_urbanizacion/model/gc0032a.dart';
import 'package:project_urbanizacion/model/gc0032c.dart';
import 'package:project_urbanizacion/model/gc0040.dart';
import 'package:project_urbanizacion/model/gc0042.dart';
import 'package:project_urbanizacion/model/http/auth_response.dart';
import 'package:project_urbanizacion/model/http/cobranza.dart';
import 'package:project_urbanizacion/model/http/historial.dart';

class SolicitudApi {
  //192.168.3.57
  static String dominio = "192.168.3.57:8080";
  static String path = "/regularizacion";

  Future<Authentication?> login(String email, String pass) async {
    var url = Uri.http(dominio, '$path/login', {'correo': email, 'pass': pass});

    try {
      //print(url);
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Authentication.fromJson(utf8.decode(respuesta.bodyBytes))
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

  Future<String> postinsertGc0040(Gc0040 objeto) async {
    var url = Uri.http(dominio, '$path/insertGc0040');

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

  Future<String> postinsertGc0042(Gc0042 objeto) async {
    var url = Uri.http(dominio, '$path/insertGc0042');
    try {
      final resquet = await http.post(url,
          body: objeto.toJson(),
          headers: {"Content-type": "application/json;charset=UTF-8"});
      if (resquet.statusCode != 200) {
        throw Exception('${resquet.statusCode}');
      } else {
        return utf8.decode(resquet.bodyBytes);
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<String> postinsertGc0020Cob(Gc0020Cob objeto) async {
    var url = Uri.http(dominio, '$path/insertGc0020cob');

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

  Future<String> postinsertGc0020Cobranza(
      Gc0020Cob objeto, String value) async {
    var url = Uri.http(dominio, '$path/insertCobranzaCab', {"value": value});

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

  Future<bool> putGc0001(Gc0001 datos) async {
    var url = Uri.http(dominio, '$path/updateGc0001');

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

  Future<Gc0032?> getHabitante(String value) async {
    var url = Uri.http(dominio, '$path/getHabitante', {'cedula': value});

    try {
      //print(url);
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Gc0032.fromJson(utf8.decode(respuesta.bodyBytes))
            : null;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
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

  Future<Gc0001?> getGc0001(String codEmp) async {
    var url = Uri.http(dominio, '$path/getCommitte', {"codEmp": codEmp});

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

  Future<Gc0001?> getGc0001CodEmp(String empresa) async {
    var url = Uri.http(dominio, '$path/getCommitteEmpresa', {"value": empresa});

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

  Future<String?> getMaxNumTul() async {
    var url = Uri.http(dominio, '$path/getMaxNumTul');

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? utf8.decode(respuesta.bodyBytes).trim()
            : null;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<String?> getMaxNtaLot() async {
    var url = Uri.http(dominio, '$path/getMaxNtaLot');

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? utf8.decode(respuesta.bodyBytes).trim()
            : null;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<String?> getMaxNumDup() async {
    var url = Uri.http(dominio, '$path/getMaxNumDup');

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? utf8.decode(respuesta.bodyBytes).trim()
            : null;
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('$e');
    }
  }

  Future<List<Gc0032LOT>> getListGc0032LOT(String value) async {
    var url = Uri.http(dominio, '$path/getInfLoteList', {'value': value});

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseGc0032LOT(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Gc0032LOT>> getAllGc0020cob() async {
    var url = Uri.http(dominio, '$path/getAllGc0020cob');

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseGc0032LOT(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Gc0032LOT>> getListGc0020cob(String value) async {
    var url =
        Uri.http(dominio, '$path/getSecNicAllGc0020cob', {'value': value});

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseGc0032LOT(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Cobranza>> getListCobranza() async {
    var url = Uri.http(dominio, '$path/getCobranza');

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseCobranza(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Gc0020Cob>> getListCobranzaDet(String value) async {
    var url = Uri.http(dominio, '$path/getCobranzaDet', {"value": value});

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseGc0020Cob(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Historial>> getAllCobranzaHist(String value) async {
    var url = Uri.http(dominio, '$path/getAllCobranzaHist', {"value": value});

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseHistorial(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception(respuesta.statusCode.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Gc0020Cob?> getCobranzaCab(String value, String secnic) async {
    var url = Uri.http(
        dominio, '$path/getCobranzaCab', {"nummov": value, "secnic": secnic});

    try {
      //print(url);
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes) != ""
            ? Gc0020Cob.fromJson(utf8.decode(respuesta.bodyBytes))
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

  List<Gc0032LOT> parseGc0032LOT(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Gc0032LOT>((json) => Gc0032LOT.fromMap(json)).toList();
  }

  List<Gc0020Cob> parseGc0020Cob(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Gc0020Cob>((json) => Gc0020Cob.fromMap(json)).toList();
  }

  List<Cobranza> parseCobranza(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cobranza>((json) => Cobranza.fromMap(json)).toList();
  }

  List<Historial> parseHistorial(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Historial>((json) => Historial.fromMap(json)).toList();
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
