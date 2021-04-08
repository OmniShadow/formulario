import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:formulario/MateriaData.dart';

class Assets {
  HashMap<String, MateriaData> _materieDataMap;
  static Assets _assets;

  Assets._() {
    _loadMaterie();
  }

  static Assets instance() =>
      (_assets == null ? _assets = Assets._() : _assets);
  MateriaData getMateriaData(String key) {
    return _materieDataMap[key];
  }

  Future<void> _loadMaterie() async {
    List<String> materieNomi = [
      'matematica',
    ];
    String jsonString;
    var jsonResponse;

    for (String nomeMateria in materieNomi) {
      jsonString = await _loadMaterieAsset(nomeMateria);
      jsonResponse = json.decode(jsonString);
      _materieDataMap.putIfAbsent(
          nomeMateria, () => MateriaData.fromJson(jsonResponse));
    }
    print('Materie caricate con successo');
  }

  Future<String> _loadMaterieAsset(String materiaNome) async {
    materiaNome = ('assets/' + materiaNome + '.json');
    return await rootBundle.loadString(materiaNome);
  }
}
