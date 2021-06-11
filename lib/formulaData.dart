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
  FormulaData({this.titolo, this.testo, this.categoria, this.descrizione}) {
    id = n++;
    print('$id $titolo');
  }
  FormulaData.withId(
      {this.id, this.titolo, this.testo, this.categoria, this.descrizione});

  factory FormulaData.fromJson(
      Map<String, dynamic> parsedJson, String categoria) {
    return FormulaData(
      titolo: parsedJson['titolo'],
      testo: parsedJson['testo'],
      descrizione: parsedJson['descrizione'],
      categoria: categoria,
    );
  }
  MaterialPageRoute getFormulaMaterialPage() {
    Assets.instance.updateFormuleRecenti(this);
    return MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(titolo),
            ),
            body: Column(
              children: [
                FittedBox(
                  child: Card(
                    child: Math.tex(
                      testo,
                      textScaleFactor: 7.0,
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
