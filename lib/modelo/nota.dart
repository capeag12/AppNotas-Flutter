class Nota {
  static int _idAutoIncremento = 1;
  int id = -1;
  String texto = "";
  DateTime fecha = DateTime.now();

  Nota(String texto) {
    this.id = _idAutoIncremento;
    this.texto = texto;
    _idAutoIncremento += 1;
  }
}
