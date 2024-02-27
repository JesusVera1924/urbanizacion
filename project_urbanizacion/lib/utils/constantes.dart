import 'package:project_urbanizacion/model/gc0001.dart';

class Constantes {
  static late Gc0001 selectEmpresa;

  //EXPRESIONES IRREGULARES -------------------------------------------------------------------------------------------------------------
  //SOLO NUMEROS
  static const String numeros = r'^(?:\+|-)?\d+$';
  //SOLO FECHAS
  static const String fecha =
      r'^(0?[1-9]|[12][0-9]|3[01])[\/](0?[1-9]|1[012])[/\\/](19|20)\d{2}$';

  //SOLO NUMERO Y SE PERMITE UN DECIMAL
  static const String decimal = r'^(\d+)?\.?\d{0,3}';

  //SOLO LETRAS Y ESPACIO
  static const String letras = r'(^[a-zA-Z ]*$)';

  //SOLO NUMEROS LETRAS Y PUNTO Y GUION PERMITIDOS
  static const String alfanumerico = r'(^[a-zA-Z 0-9.-]*$)';

  //SOLO NUMEROS LETRAS, GUION, CORREO, PUNTO Y COMA
  static const String correo = r'(^[a-zA-Z0-9-_@. ]*$)';
}
