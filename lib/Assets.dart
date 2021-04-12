import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:formulario/materiaData.dart';

class Assets {
  Map<String, MateriaData> _materieDataMap;
  static Assets _assets;
  static List<String> materieNomi = [
    'Matematica',
    'Fisica',
    'Geometria',
    'Probabilita'
  ];

  Assets._() {
    _materieDataMap = Map<String, MateriaData>();
  }

  static Assets instance() =>
      (_assets == null ? _assets = Assets._() : _assets);
  MateriaData getMateriaData(String key) {
    return _materieDataMap[key];
  }

  Future<void> loadMaterie() async {
    try {
      for (String materiaNome in materieNomi) {
        print(materiaNome);
        final String jsonString = await rootBundle
            .loadString('/materieData/' + materiaNome.toLowerCase() + '.json');
        var jsonResponse = await json.decode(jsonString);
        MateriaData materiaData = MateriaData.fromJson(jsonResponse, '');
        print('assets: ' + materiaData.materiaTitle);
        _materieDataMap[materiaNome] = materiaData;
        print('Materie caricate con successo');
      }
    } catch (e) {
      print(e);
    }
  }
}
