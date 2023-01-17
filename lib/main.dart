import 'package:appnotas/modelo/nota.dart';
import 'package:appnotas/modelo/servicio.dart';
import 'package:appnotas/widgets/notaWidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        colorSchemeSeed: Color.fromARGB(255, 204, 250, 0), useMaterial3: true),
    home: _MyApp(),
  ));
}

class _MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  late TextEditingController controller;
  Servicio _servicio = Servicio();
  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  void agregarNota(String? texto) {
    if (texto == null || texto == "") {
      texto = "Texto por defecto";
    }

    String txtFinal = "" + texto;
    setState(() {
      this._servicio.addNota(Nota(txtFinal));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: Color.fromARGB(255, 204, 250, 0),
          useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 204, 250, 0),
          title: Text("Notas"),
        ),
        body: _ListaNotas(this._servicio),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String? txtNota = await openDialog();
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Añadir nota:'),
          content: TextField(
            decoration: InputDecoration(hintText: "Nota"),
            controller: this.controller,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                agregarNota(controller.text);
                Navigator.of(context).pop(controller.text);
              },
              child: Text('Aceptar'),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}

class _ListaNotas extends StatefulWidget {
  Servicio _servicio;

  _ListaNotas(this._servicio);
  @override
  _ListaNotasState createState() => _ListaNotasState(_servicio);
}

class _ListaNotasState extends State<_ListaNotas> {
  Servicio _servicio;

  _ListaNotasState(this._servicio);

  void eliminarNota(int indice) {
    setState(() {
      _servicio.eliminarNota(indice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ..._servicio.getNotas().map((e) {
          int indice = _servicio.getNotas().indexOf(e);
          return NotaWidget(e, indice, eliminarNota);
        }).toList()
      ],
    );
  }
}
