import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:formulario/assets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FormulaData {
  static int n = 0;
  String titolo;
  String testo;
  String categoria;
  bool isFavourite = false;
  int id;

  @override
  String toString() => ('Formula: ' + titolo);
  FormulaData({this.titolo, this.testo, this.categoria}) {
    id = n++;
  }
  FormulaData.withId({this.id, this.titolo, this.testo, this.categoria});

  Map<String, dynamic> toMap() => {
        'id': id,
        'titolo': titolo,
        'testo': testo,
        'categoria': categoria,
      };
  FormulaData fromMap(Map<String, dynamic> map) => FormulaData.withId(
        id: map['id'],
        titolo: map['titolo'],
        categoria: map['categoria'],
        testo: map['testo'],
      );

  factory FormulaData.fromJson(
      Map<String, dynamic> parsedJson, String categoria) {
    return FormulaData(
      titolo: parsedJson['titolo'],
      testo: parsedJson['testo'],
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
                    initialUrl: 'https://www.google.it/search?q=' + titolo,
                  ),
                ),
              ],
            )));
  }
}
