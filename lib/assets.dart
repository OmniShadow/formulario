import 'dart:convert';
import 'dart:io';
import 'package:formulario/formulaData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:formulario/materiaData.dart';

class Assets {
  //variabili necessarie alla gestione del database locale delle materie e delle formule associate
  static const int maxRecenti = 5;
  List<String> materieNomi = [];
  Map<String, MateriaData> _materieDataMap = {};
  Map<int, FormulaData> _formule = {};
  List<FormulaData> _formulePreferite = [];
  List<FormulaData> _formuleRecenti = [];
  List<MateriaData> _materieRecenti = [];

  //istanza della classe UserData dove verranno memorizzati i dati forniti dall'utente
  UserData userData = UserData(
    username: '',
    email: '',
    cosaFare: '',
  );

  //Approcio singleton per la gestione delle istanze della classe Assets.
  static Assets _assets;

  Assets._();

  static Assets get instance =>
      (_assets == null ? _assets = Assets._() : _assets);
  /*_____________________________________________________________________*/

  //metodo per il caricamento iniziale dei dati
  Future setup() async {
    await _loadMaterie();
    _loadFormule();
    await _leggiPreferiti();
    await _leggiRecenti();
    await _leggiUsername();
    return Future.delayed(Duration(seconds: 2));
  }

  //metodo per accedere alle materie
  MateriaData getMateriaData(String key) {
    return _materieDataMap[key];
  }

  //getters
  List<FormulaData> get formulePreferite => _formulePreferite;
  List<FormulaData> get formuleRecenti => _formuleRecenti;
  List<MateriaData> get materieRecenti => _materieRecenti;

  /*Questi metodi sono utilizatti per la gestione dei file*/

  //metodo per ottenere il path della directory principale
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //metodo per ottenere un file in base al nome scelto
  static Future<File> _getLocalFile(String nome) async {
    final path = await _localPath;
    File file = File('$path/$nome');

    bool exists = await file.exists();

    if (!exists) await file.create();
    return file;
  }
/*_________________________________________________________*/

  /*-----Metodi per update, salvataggio e lettura dei preferiti-----*/

  void updatePreferiti(FormulaData formula) {
    if (_formulePreferite.contains(formula)) {
      _formulePreferite.remove(formula);
      formula.isFavourite = false;
    } else
      _formulePreferite.add(formula);
    _salvaPreferiti();
  }

  //A ogni formula vi è associato un id univoco, per salvare le formule preferite
  //viene scritta su un file la lista di interi contenente gli id associati alle formule preferite
  Future _salvaPreferiti() async {
    final file = await _getLocalFile('preferiti');
    if (await file.exists()) await file.delete();

    List<int> prefIds = [];
    for (FormulaData formula in _formulePreferite) {
      prefIds.add(formula.id);
    }
    await file.writeAsBytes(prefIds);
  }

  //Viene letta da file una lista di interi contenenti gli id delle formule preferite
  //e dalla mappa _formule e dagli id vengono recuperate le istanze delle formule preferite
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
  /*_________________________________________________________*/

  /*-----Metodi per update, salvataggio e lettura delle formule e materie recenti-----*/

  //In questo metodo aggiungiamo le formule visualizzate di recente, nel caso
  //in cui la formula è contenuta non verrà riaggiunta, mentre nel caso
  //venga superato il numero massimo (maxRecenti) rimuove la prima che ha aggiunto
  void updateFormuleRecenti(FormulaData formula) {
    if (!_formuleRecenti.contains(formula)) {
      if (_formuleRecenti.length >= maxRecenti) _formuleRecenti.removeAt(0);
      _formuleRecenti.add(formula);
      _salvaRecenti();
    }
  }

  //Stesso funzionamento dell'updateFormuleRecenti
  void updateMaterieRecenti(MateriaData materia) {
    if (!_materieRecenti.contains(materia)) {
      if (_materieRecenti.length >= maxRecenti) _materieRecenti.removeAt(0);
      _materieRecenti.add(materia);
    }
  }

  //Questo metodo cancella le formule e le materie recenti
  void clearRecenti() {
    _formuleRecenti.clear();
    _materieRecenti.clear();
    _salvaRecenti();
  }

  //A ogni formula vi è associato un id univoco, per salvare le formule recenti
  //viene scritta su un file la lista di interi contenente gli id associati alle formule recenti
  Future _salvaRecenti() async {
    final file = await _getLocalFile('recenti');
    await file.delete();
    List<int> recentIds = [];
    for (FormulaData formula in _formuleRecenti) {
      recentIds.add(formula.id);
    }
    await file.writeAsBytes(recentIds);
  }

  //Viene letta da file una lista di interi contenenti gli id delle formule recenti
  //e dalla mappa _formule e dagli id vengono recuperate le istanze delle formule recenti
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
  /*_________________________________________________________*/

  /*-----Metodi per update, salvataggio e lettura dei dati dell'utente-----*/
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
  /*_________________________________________________________*/

  /*------Metodi per il caricamento delle materie dai file .json------*/

  //Metodo per creare una lista dei path dei file all'interno della cartella materieData in assets
  Future<List<String>> _leggiNomi(String folderName) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final List<String> paths = manifestMap.keys
        .where((String key) => key.contains('$folderName/'))
        .where((String key) => key.contains('.json'))
        .toList();
    return paths;
  }

  //Metodo per caricare nella mappa _materieData i dati delle materie all'interno dei file .json
  //che si trovano nella cartella materieData
  Future _loadMaterie() async {
    try {
      List<String> paths = await _leggiNomi('materieData');
      for (String path in paths) {
        final String jsonString = await rootBundle.loadString(path);
        var jsonResponse = await json.decode(jsonString);
        MateriaData materiaData = MateriaData.fromJson(jsonResponse, '');

        String materiaNome = path.split('/').last.split('.').first;
        materieNomi.add(materiaNome);
        _materieDataMap[materiaNome] = materiaData;
      }
    } catch (e) {
      print(e);
    }
  }

  //Metodo per caricare le formule in base al loro id nella mappa _formule
  void _loadFormule() {
    List<MateriaData> materie = [];
    materie = materieNomi.map((e) => _materieDataMap[e]).toList();
    for (MateriaData materia in materie) {
      List<FormulaData> formule = materia.getFormule();
      for (FormulaData formula in formule) _formule[formula.id] = formula;
    }
  }
  /*_____________________________________________________________________*/

}

class UserData {
  //Classe contenente i dati personali dell'utente
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
