import 'package:formulario/formulaData.dart';

class MateriaData {
  List<MateriaData> subMaterie;
  List<FormulaData> formule;
  String iconPath;
  String materiaTitle;
  bool isFavouritable = false;
  bool isFavourite = false;
  int colorValue;

  MateriaData({
    this.iconPath,
    this.materiaTitle,
    this.subMaterie,
    this.formule,
    this.isFavouritable,
    this.colorValue,
  });

  factory MateriaData.fromJson(Map<String, dynamic> parsedJson) {
    List<dynamic> _subMaterie = [];
    List<dynamic> _formule = [];
    List<FormulaData> formuleData = [];
    List<MateriaData> subMaterieData = [];
    var materieJson;
    var formuleJson;

    materieJson = parsedJson['materie'];
    if (!materieJson.isEmpty) {
      _subMaterie = materieJson.map((i) => MateriaData.fromJson(i)).toList();
      for (dynamic _subMateria in _subMaterie) {
        subMaterieData.add(_subMateria as MateriaData);
      }
    } else {
      subMaterieData = [];
    }
    formuleJson = parsedJson['formule'];

    if (!formuleJson.isEmpty) {
      _formule = formuleJson.map((i) => FormulaData.fromJson(i)).toList();
      for (dynamic _formula in _formule) {
        formuleData.add(_formula as FormulaData);
      }
    } else {
      formuleData = [];
    }
    return MateriaData(
      colorValue: int.parse(parsedJson['color']),
      iconPath: parsedJson['icona'] as String,
      materiaTitle: parsedJson['materia'] as String,
      subMaterie: subMaterieData,
      formule: formuleData,
      isFavouritable: parsedJson['isFavouritable'],
    );
  }
}
