import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  var faqListMap = [];

  //Approcio singleton per la gestione delle istanze della classe Assets.
  static Assets? _assets;
  Assets._();

  static Assets? get instance =>
      (_assets == null ? _assets = Assets._() : _assets);
  /*_____________________________________________________________________*/

  //metodo per il caricamento iniziale dei dati
  Future setup() async {
    //inizializzazione di Firebase
    await Firebase.initializeApp();
    //await _loadMaterie();
    await loadMaterieFirebase();
    await _leggiPreferiti();
    await _leggiFormuleRecenti();
    await _leggiMaterieRecenti();
    await loadFaqFirebase();
  }

  //Caricamente delle FAQ dal database di Firebase
  Future loadFaqFirebase() async {
    var doc = await FirebaseFirestore.instance.collection('faq').get();
    var faqs = doc.docs;
    var faqData = faqs[0].data();
    faqListMap = faqData['faq'];
  }

  Future loadMaterieFirebase() async {
    //resetto le variabili per memorizzare le materie e le formule
    _materieDataMap = {};
    FormulaData.n = 0;
    _formule = {};

    //ottengo la collecion 'materie' da Firebase
    CollectionReference collection =
        FirebaseFirestore.instance.collection('materie');

    QuerySnapshot querySnapshot = await collection.get();

    //leggo tutti i documenti associati alla collection 'materie'
    var documenti = querySnapshot.docs;

    //per ogni documento che rappresenta una materia istanzio i dati delle materie e le memorizzo in _materieDataMap
    documenti.forEach((materia) {
      Map<String, dynamic> materiaMap = materia.data() as Map<String, dynamic>;
      String materiaNome = materiaMap['materia'];
      if (!materieNomi.contains(materiaNome)) materieNomi.add(materiaNome);
      _materieDataMap[materiaNome] = MateriaData.fromJson(materiaMap, '');
    });

    //una volta caricate le materie carico le formule
    _loadAllMaterie();
    _loadFormule();
  }

  void _loadAllMaterie() {
    List<MateriaData> materieList = [];
    _materieDataMap.forEach((key, value) {
      materieList.addAll(value.getMaterie());
    });
    materieList.forEach((element) {
      _materieDataMap[element.categoria] = element;
      if (!materieNomi.contains(element.categoria))
        materieNomi.add(element.categoria);
    });
  }

  //Vecchio metodo utilizzato per caricare nella mappa _materieData i dati delle materie all'interno dei file .json
  //che si trovano nella cartella materieData
  // Future _loadMaterie() async {
  //   try {
  //     List<String> paths = await _leggiNomi('materieData');
  //     for (String path in paths) {
  //       final String jsonString = await rootBundle.loadString(path);
  //       var jsonResponse = await json.decode(jsonString);
  //       MateriaData materiaData = MateriaData.fromJson(jsonResponse, '');

  //       String materiaNome = path.split('/').last.split('.').first;
  //       materieNomi.add(materiaNome);
  //       _materieDataMap[materiaNome] = materiaData;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  //metodo per accedere alle materie
  MateriaData getMateriaData(String key) {
    return _materieDataMap[key]!;
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
    file.openWrite();

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
        updatePreferiti(_formule[id]!);
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
    }
    _salvaFormuleRecenti();
  }

  void removeFormulaRecente(FormulaData formula) {
    _formuleRecenti.remove(formula);
  }

  //Stesso funzionamento dell'updateFormuleRecenti
  void updateMaterieRecenti(MateriaData materia) {
    if (!_materieRecenti.contains(materia)) {
      if (_materieRecenti.length >= maxRecenti) _materieRecenti.removeAt(0);
      _materieRecenti.add(materia);
    }
    _salvaMaterieRecenti();
  }

  void removeMateriaRecente(MateriaData materia) {
    _materieRecenti.remove(materia);
  }

  //Questo metodo cancella le formule e le materie recenti
  void clearRecenti() {
    _formuleRecenti.clear();
    _materieRecenti.clear();
    _salvaFormuleRecenti();
    _salvaMaterieRecenti();
  }

  //A ogni formula vi è associato un id univoco, per salvare le formule recenti
  //viene scritta su un file la lista di interi contenente gli id associati alle formule recenti
  Future _salvaFormuleRecenti() async {
    final file = await _getLocalFile('formuleRecenti');
    file.openWrite();
    List<int> recentIds = [];
    for (FormulaData formula in _formuleRecenti) {
      recentIds.add(formula.id);
    }
    await file.writeAsBytes(recentIds);
  }

  //Viene letta da file una lista di interi contenenti gli id delle formule recenti
  //e dalla mappa _formule e dagli id vengono recuperate le istanze delle formule recenti
  Future _leggiFormuleRecenti() async {
    try {
      final File file = await _getLocalFile('formuleRecenti');
      List<int> recentIds = [];
      recentIds.addAll(await file.readAsBytes());
      for (int id in recentIds) {
        updateFormuleRecenti(_formule[id]!);
      }
    } catch (e) {
      print(e);
    }
  }

  Future _salvaMaterieRecenti() async {
    final file = await _getLocalFile('materieRecenti');
    file.openWrite();
    String materieRecentiString = '';
    _materieRecenti.forEach((element) {
      materieRecentiString = '$materieRecentiString${element.categoria}\\';
    });
    await file.writeAsString(materieRecentiString);
  }

  //Viene letta da file una lista di interi contenenti gli id delle formule recenti
  //e dalla mappa _formule e dagli id vengono recuperate le istanze delle formule recenti
  Future _leggiMaterieRecenti() async {
    try {
      final File file = await _getLocalFile('materieRecenti');
      String recentiString = (await file.readAsString());
      recentiString.split('\\').forEach((element) {
        updateMaterieRecenti(_materieDataMap[element]!);
      });
    } catch (e) {
      print(e);
    }
  }
  /*_________________________________________________________*/

  /*------Metodi per il caricamento delle materie dai file .json------*/

  //Metodo per creare una lista dei path dei file all'interno della cartella materieData in assets
  // Future<List<String>> _leggiNomi(String folderName) async {
  //   final manifestContent = await rootBundle.loadString('AssetManifest.json');
  //   final Map<String, dynamic> manifestMap = json.decode(manifestContent);
  //   final List<String> paths = manifestMap.keys
  //       .where((String key) => key.contains('$folderName/'))
  //       .where((String key) => key.contains('.json'))
  //       .toList();
  //   return paths;
  // }

  //Metodo per caricare le formule in base al loro id nella mappa _formule
  void _loadFormule() {
    List<MateriaData> materie = [];
    materie = materieNomi.map((e) => _materieDataMap[e]!).toList();
    for (MateriaData materia in materie) {
      List<FormulaData> formule = materia.getFormule();
      for (FormulaData formula in formule) _formule[formula.id] = formula;
    }
  }
  /*_____________________________________________________________________*/

}
