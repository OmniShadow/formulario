import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:formulario/assets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FormulaData {
  static int n = 0;
  String titolo;
  String testo;
  String categoria;
  String descrizione;
  bool isFavourite = false;
  int id;

  @override
  String toString() => ('Formula: $titolo ,ID: $id');
  FormulaData({
    required this.titolo,
    required this.testo,
    required this.categoria,
    required this.descrizione,
    this.id = 0,
  }) {
    id = n++; //id a incremento
  }

  Map<String, dynamic> toJson() => {
        'titolo': titolo,
        'testo': testo,
        'descrizione': descrizione,
      };

  //Metodo per istanziare un oggetto di tipo FormulaData da un file .json
  factory FormulaData.fromJson(
      Map<String, dynamic> parsedJson, String categoria) {
    return FormulaData(
      titolo: parsedJson['titolo'],
      testo: parsedJson['testo'],
      descrizione: parsedJson['descrizione'],
      categoria: categoria,
    );
  }
  //Metodo per ottenere la pagina web con la ricerca su google della formula
  MaterialPageRoute getFormulaMaterialPage() {
    Assets.instance!.updateFormuleRecenti(this);
    return MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(titolo),
            ),
            body: Column(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Card(
                    child: Math.tex(
                      testo,
                      textScaleFactor: 5.0,
                    ),
                  ),
                ),
                Expanded(
                  child: WebView(
                    initialUrl: 'https://www.google.it/search?q=$titolo',
                  ),
                ),
              ],
            )));
  }
}
