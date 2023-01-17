import 'package:appnotas/modelo/nota.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotaWidget extends StatelessWidget {
  void Function(int) _funcion;
  Nota _nota;
  int _indice;

  NotaWidget(this._nota, this._indice, this._funcion);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromARGB(255, 27, 27, 27)))),
      child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Text(_nota.texto)),
              ElevatedButton(
                  onPressed: () => _funcion(_indice), child: Text("Eliminar"))
            ],
          )),
    );
  }
}
