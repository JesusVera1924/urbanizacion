import 'dart:convert';

class Cobranza {
  final String movimiento;
  final String titulo;
  final String subtitulo;
  final int couta;
  final double total;
  final int contar;

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
