import 'package:formulario/formulaData.dart';

class MateriaData {
  List<MateriaData> subMaterie;
  List<FormulaData> formule;
  String iconPath;
  String materiaTitle;
  String categoria;
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
    this.categoria,
  });

  List<MateriaData> getMaterie() {
    List<MateriaData> materie = [];
    materie.addAll(subMaterie);
    for (MateriaData subMateria in subMaterie)
      materie.addAll(subMateria.getMaterie());
    return materie;
  }

  List<FormulaData> getFormule() {
    List<FormulaData> formuleAll = [];
    formuleAll.addAll(formule);
    List<MateriaData> materie = getMaterie();
    for (MateriaData materia in materie) {
      formuleAll.addAll(materia.getFormule());
    }
    return formuleAll;
  }

  factory MateriaData.fromJson(
      Map<String, dynamic> parsedJson, String categoria) {
    List<dynamic> _subMaterie = [];
    List<dynamic> _formule = [];
    List<FormulaData> formuleData = [];
    List<MateriaData> subMaterieData = [];
    var materieJson;
    var formuleJson;

    categoria =
        categoria + (categoria.isEmpty ? '' : ':') + parsedJson['materia'];

    materieJson = parsedJson['materie'];
    if (!materieJson.isEmpty) {
      _subMaterie =
          materieJson.map((i) => MateriaData.fromJson(i, categoria)).toList();
      for (dynamic _subMateria in _subMaterie) {
        subMaterieData.add(_subMateria as MateriaData);
      }
    } else {
      subMaterieData = [];
    }
    formuleJson = parsedJson['formule'];

    if (!formuleJson.isEmpty) {
      _formule =
          formuleJson.map((i) => FormulaData.fromJson(i, categoria)).toList();
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
      categoria: categoria,
    );
  }
}
