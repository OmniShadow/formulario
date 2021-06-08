import 'dart:convert';
import 'dart:io';
import 'package:formulario/formulaData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:formulario/materiaData.dart';

class Assets {
  Map<String, MateriaData> _materieDataMap;
  Map<int, FormulaData> _formule = {};
  List<FormulaData> _formulePreferite = [];
  List<FormulaData> _formuleRecenti = [];
  List<MateriaData> _materieRecenti = [];
  UserData userData;

  static const int maxRecenti = 5;
  static bool areLoaded = false;
  static Assets _assets;
  List<String> materieNomi = [
    'Matematica',
    'Fisica',
    'Geometria',
    'Probabilita'
  ];

  Assets._() {
    _materieDataMap = Map<String, MateriaData>();
    loadMaterie().then((value) {
      loadFormule();
      _leggiPreferiti();
      _leggiRecenti();
      _leggiUsername();
    });
  }

  static Assets get instance =>
      (_assets == null ? _assets = Assets._() : _assets);

  MateriaData getMateriaData(String key) {
    return _materieDataMap[key];
  }

  void updateFormuleRecenti(FormulaData formula) {
    if (!_formuleRecenti.contains(formula)) {
      if (_formuleRecenti.length >= maxRecenti) _formuleRecenti.removeAt(0);
      _formuleRecenti.add(formula);
      _salvaRecenti();
    }
  }

  void updateMaterieRecenti(MateriaData materia) {
    if (!_materieRecenti.contains(materia)) {
      if (_materieRecenti.length >= maxRecenti) _materieRecenti.removeAt(0);
      _materieRecenti.add(materia);
    }
  }

  void clearRecenti() {
    _formuleRecenti.clear();
    _materieRecenti.clear();
    _salvaRecenti();
  }

  void updatePreferiti(FormulaData formula) {
    if (_formulePreferite.contains(formula)) {
      _formulePreferite.remove(formula);
      formula.isFavourite = false;
    } else
      _formulePreferite.add(formula);
    _salvaPreferiti();
  }

  //getters
  List<FormulaData> get formulePreferite => _formulePreferite;
  List<FormulaData> get formuleRecenti => _formuleRecenti;
  List<MateriaData> get materieRecenti => _materieRecenti;

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _getLocalFile(String nome) async {
    final path = await _localPath;
    File file = File('$path/$nome');
    bool exists = await file.exists();
    if (!exists) await file.create();
    return file;
  }

  //preso da stackoverflow da utilizzare più avanti per aggiungere facilmente altri .json
  Future _leggiNomi() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final paths = manifestMap.keys
        .where((String key) => key.contains('materieData/'))
        .where((String key) => key.contains('.json'))
        .toList();
    print(paths);
  }

  Future<File> _salvaPreferiti() async {
    final file = await _getLocalFile('preferiti');
    List<int> prefIds = [];
    for (FormulaData formula in _formulePreferite) {
      prefIds.add(formula.id);
    }
    return file.writeAsBytes(prefIds);
  }

  Future<File> _salvaRecenti() async {
    final file = await _getLocalFile('recenti');
    List<int> recentIds = [];
    for (FormulaData formula in _formuleRecenti) {
      recentIds.add(formula.id);
    }
    return file.writeAsBytes(recentIds);
  }

  Future _leggiPreferiti() async {
    try {
      final File file = await _getLocalFile('preferiti');
      List<int> prefIds = [];
      prefIds.addAll(await file.readAsBytes());
      for (int id in prefIds) {
        updatePreferiti(_formule[id]);
      }
    } catch (e) {
      print(e);
    }
  }

  Future _leggiRecenti() async {
    try {
      final File file = await _getLocalFile('recenti');
      List<int> recentIds = [];
      recentIds.addAll(await file.readAsBytes());
      for (int id in recentIds) {
        updateFormuleRecenti(_formule[id]);
      }
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

  void updateUsername(String username, String email) {
    this.userData = UserData(username: username, email: email);
    _salvaUsername();
  }

  Future _leggiUsername() async {
    final File file = await _getLocalFile('username');
    String userDataString = await file.readAsString();
    if (userDataString.isNotEmpty)
      userData = UserData.fromString(userDataString);
  }

  Future _salvaUsername() async {
    final File file = await _getLocalFile('username');
    file.writeAsString(userData.toString());
  }
}

class UserData {
  String email;
  String username;
  UserData({this.username, this.email});
  @override
  String toString() {
    return ('$username\\$email');
  }

  factory UserData.fromString(String userDataString) {
    List<String> userDataStringList = userDataString.split('\\');
    if (userDataStringList.length == 2)
      return UserData(
          username: userDataStringList[0], email: userDataStringList[1]);
    return UserData(username: '', email: '');
  }
}
