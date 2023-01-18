import 'dart:convert';
import 'dart:io';

import 'package:appnotas/modelo/nota.dart';
import 'package:appnotas/modelo/servicio.dart';
import 'package:appnotas/widgets/notaWidget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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

class _MyAppState extends State<_MyApp> with WidgetsBindingObserver {
  late TextEditingController controller;
  Servicio _servicio = Servicio();

  _MyAppState();
  @override
  void initState() {
    super.initState();

    leerJson().then((value) {
      if (value == "") {
        print("No hay json que recuperar");
      } else {
        var listaJSON = jsonDecode(value);
        List<Nota> listaNotas = [];
        print(listaJSON);

        for (var element in listaJSON) {
          print(element);
          listaNotas
              .add(Nota(element['texto'], DateTime.parse(element['fecha'])));
        }

        setState(() {
          this._servicio.setNotas(listaNotas);
        });
      }
    });
    controller = TextEditingController();
  }

  escribir() async {
    String json = jsonEncode(this._servicio.getNotas());
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    File archivo = await File('${directory.path}/notas.json');
    await archivo.writeAsString(json);
  }

  Future<String> leerJson() async {
    String text = "";
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      File file = File('${directory.path}/notas.json');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  void agregarNota(String? texto) {
    if (texto == null || texto == "") {
      texto = "Texto por defecto";
    }

    String txtFinal = "" + texto;
    setState(() {
      this._servicio.addNota(Nota(txtFinal, DateTime.now()));
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
                controller.text = "";
                Navigator.of(context).pop(controller.text);
                escribir();
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

  escribir() async {
    String json = jsonEncode(this._servicio.getNotas());
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    File archivo = await File('${directory.path}/notas.json');
    await archivo.writeAsString(json);
  }

  void eliminarNota(int indice) {
    setState(() {
      _servicio.eliminarNota(indice);
    });
    escribir();
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
