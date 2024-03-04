import 'dart:convert';

class Cobranza {
  String movimiento;
  String titulo;
  String subtitulo;
  int couta;
  double total;
  int contar;

  Cobranza({
    required this.movimiento,
    required this.titulo,
    required this.subtitulo,
    required this.couta,
    required this.total,
    required this.contar,
  });

  factory Cobranza.fromJson(String str) => Cobranza.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cobranza.fromMap(Map<String, dynamic> json) => Cobranza(
        movimiento: json["movimiento"],
        titulo: json["titulo"],
        subtitulo: json["subtitulo"],
        couta: json["couta"],
        total: json["total"],
        contar: json["contar"],
      );

  Map<String, dynamic> toMap() => {
        "movimiento": movimiento,
        "titulo": titulo,
        "subtitulo": subtitulo,
        "couta": couta,
        "total": total,
        "contar": contar,
      };
}
