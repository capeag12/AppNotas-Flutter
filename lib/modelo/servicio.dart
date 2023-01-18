import 'package:appnotas/modelo/nota.dart';

class Servicio {
  List<Nota> _listaNotas = [];

  Servicio();

  List<Nota> getNotas() {
    return _listaNotas;
  }

  void addNota(Nota n) {
    this._listaNotas.add(n);
  }

  void setNotas(List<Nota> list) {
    this._listaNotas = list;
  }

  void eliminarNota(int index) {
    this._listaNotas.removeAt(index);
  }

  Nota getNota(int index) {
    return _listaNotas[index];
  }
}
