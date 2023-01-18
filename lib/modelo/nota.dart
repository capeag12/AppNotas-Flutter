import 'dart:convert';

class Nota {
  String texto = "";
  DateTime fecha = DateTime.now();

  Nota(this.texto, this.fecha);

  Nota.fromJson(Map<String, dynamic> json)
      : texto = json['texto'],
        fecha = DateTime.parse(json['fecha']);

  Map<String, dynamic> toJson() => {'texto': texto, 'fecha': fecha.toString()};
}
