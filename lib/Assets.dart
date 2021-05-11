import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:formulario/materiaData.dart';

import 'formulaData.dart';

class Assets {
  Map<String, MateriaData> _materieDataMap;
  Map<int, FormulaData> _formule = {};
  List<FormulaData> _formulePreferite = [];
  static bool areLoaded = false;
  static Assets _assets;
  static List<String> materieNomi = [
    'Matematica',
    'Fisica',
    'Geometria',
    'Probabilita'
  ];

  Assets._() {
    _materieDataMap = Map<String, MateriaData>();
    loadMaterie().then((value) {
      loadFormule();
      leggiPreferiti();
    });
  }

  static Assets instance() =>
      (_assets == null ? _assets = Assets._() : _assets);

  MateriaData getMateriaData(String key) {
    return _materieDataMap[key];
  }

  void updatePreferiti(FormulaData formula) {
    if (_formulePreferite.contains(formula))
      _formulePreferite.remove(formula);
    else
      _formulePreferite.add(formula);
    print(_formulePreferite);
    _salvaPreferiti();
  }

  List<FormulaData> getFormulePreferite() => _formulePreferite;

  void aggiungiFormulaPreferiti(FormulaData formula) {
    _formulePreferite.add(formula);
    _salvaPreferiti();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/assets/preferiti');
  }

  Future<File> _salvaPreferiti() async {
    final file = await _localFile;
    List<int> prefIds = [];
    for (FormulaData formula in _formulePreferite) {
      prefIds.add(formula.id);
    }
    return file.writeAsBytes(prefIds);
  }

  Future leggiPreferiti() async {
    try {
      final file = await _localFile;
      List<int> prefIds = [];
      prefIds.addAll(await file.readAsBytes());
      for (int id in prefIds) {
        _formulePreferite.add(_formule[id]);
      }
      print('preferiti letti');
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadMaterie() async {
    try {
      for (String materiaNome in materieNomi) {
        final String jsonString = await rootBundle.loadString(
            'assets/materieData/' + materiaNome.toLowerCase() + '.json');
        var jsonResponse = await json.decode(jsonString);
        MateriaData materiaData = MateriaData.fromJson(jsonResponse, '');
        _materieDataMap[materiaNome] = materiaData;
      }
    } catch (e) {
      print(e);
    }
    return Future<void>.delayed(Duration(seconds: 1));
  }

  void loadFormule() {
    List<MateriaData> materie = [];
    materie.add(_materieDataMap['Matematica']);
    materie.add(_materieDataMap['Fisica']);
    materie.add(_materieDataMap['Geometria']);
    materie.add(_materieDataMap['Probabilita']);
    for (MateriaData materia in materie) {
      List<FormulaData> formule = materia.getFormule();
      for (FormulaData formula in formule) _formule[formula.id] = formula;
    }
  }
}
