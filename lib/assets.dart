import 'dart:convert';
import 'dart:io';
import 'package:formulario/formulaData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:formulario/materiaData.dart';

class Assets {
  static int numeroSalva = 0;
  Map<String, MateriaData> _materieDataMap;
  Map<int, FormulaData> _formule = {};
  List<FormulaData> _formulePreferite = [];
  List<FormulaData> _formuleRecenti = [];
  List<MateriaData> _materieRecenti = [];
  UserData userData;

  static const int maxRecenti = 5;
  static bool areLoaded = false;
  static Assets _assets;
  List<String> materieNomi = [];

  Assets._() {
    userData = UserData(
      username: '',
      email: '',
      cosaFare: '',
    );
    _materieDataMap = Map<String, MateriaData>();
  }

  Future setup() async {
    await _loadMaterie();
    print('materie caricate');
    _loadFormule();
    print(_formule);
    print('formule caricate');
    await _leggiPreferiti();
    print(formulePreferite);
    await _leggiRecenti();
    print(formuleRecenti);
    await _leggiUsername();
    print(userData);
    return Future.delayed(Duration(seconds: 2));
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

  void updatePreferiti(FormulaData formula) {
    if (_formulePreferite.contains(formula)) {
      _formulePreferite.remove(formula);
      formula.isFavourite = false;
    } else
      _formulePreferite.add(formula);
    _salvaPreferiti();
  }

  Future _salvaPreferiti() async {
    final file = await _getLocalFile('preferiti');
    if (await file.exists()) await file.delete();

    List<int> prefIds = [];
    for (FormulaData formula in _formulePreferite) {
      prefIds.add(formula.id);
    }
    await file.writeAsBytes(prefIds);
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

  Future _salvaRecenti() async {
    final file = await _getLocalFile('recenti');
    await file.delete();
    List<int> recentIds = [];
    for (FormulaData formula in _formuleRecenti) {
      recentIds.add(formula.id);
    }
    await file.writeAsBytes(recentIds);
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

  //preso da stackoverflow da utilizzare più avanti per aggiungere facilmente altri .json
  Future<List<String>> _leggiNomi() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final List<String> paths = manifestMap.keys
        .where((String key) => key.contains('materieData/'))
        .where((String key) => key.contains('.json'))
        .toList();
    return paths;
  }

  Future _loadMaterie() async {
    try {
      List<String> paths = await _leggiNomi();
      for (String path in paths) {
        final String jsonString = await rootBundle.loadString(path);
        var jsonResponse = await json.decode(jsonString);
        MateriaData materiaData = MateriaData.fromJson(jsonResponse, '');
        String materiaNome = path.split('/').last.split('.').first;
        materieNomi.add(materiaNome);
        _materieDataMap[materiaNome] = materiaData;
        print(materieNomi);
      }
    } catch (e) {
      print(e);
    }
  }

  void _loadFormule() {
    List<MateriaData> materie = [];
    print(materieNomi);
    materie = materieNomi.map((e) => _materieDataMap[e]).toList();
    print(materie);

    for (MateriaData materia in materie) {
      List<FormulaData> formule = materia.getFormule();
      for (FormulaData formula in formule) _formule[formula.id] = formula;
    }
  }

  void updateUsername(String username, String email, String cosaFare) {
    if (username == UserData.DEFAULT_USERNAME) username = '';
    if (email == UserData.DEFAULT_EMAIL) email = '';
    if (cosaFare == UserData.DEFAULT_COSAFARE) cosaFare = '';
    this.userData = UserData(
      username: username,
      email: email,
      cosaFare: cosaFare,
    );
    _salvaUsername();
  }

  Future _leggiUsername() async {
    final File file = await _getLocalFile('userdata.json');
    String userDataString = await file.readAsString();

    if (userDataString.isNotEmpty) {
      userData = UserData.fromJson(json.decode(userDataString));
      print(userData.username);
    }
  }

  Future _salvaUsername() async {
    final File file = await _getLocalFile('userdata.json');
    await file.delete();
    String jsonString = json.encode(userData.toJson());
    file.writeAsString(jsonString);
  }
}

class UserData {
  static const String DEFAULT_USERNAME = 'Username';
  static const String DEFAULT_EMAIL = 'Email';
  static const String DEFAULT_COSAFARE = 'Dimmi cosa vuoi fare';
  String email;
  String username;
  String cosaFare;
  UserData({
    this.username,
    this.email,
    this.cosaFare,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'cosaFare': cosaFare,
    };
  }

  factory UserData.fromJson(Map<String, dynamic> jsonMap) {
    return UserData(
      username: jsonMap['username'],
      email: jsonMap['email'],
      cosaFare: jsonMap['cosaFare'],
    );
  }
  @override
  String toString() => json.encode(toJson());
}
