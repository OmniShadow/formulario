import 'package:formulario/FormulaData.dart';

class MateriaData {
  List<MateriaData> subMaterie;
  List<FormulaData> formule;
  String iconPath;
  String materiaTitle;

  MateriaData(
      {this.iconPath, this.materiaTitle, this.subMaterie, this.formule});

  factory MateriaData.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    return MateriaData(
      iconPath: parsedJson['icona'],
      materiaTitle: parsedJson['materia'],
      subMaterie:
          parsedJson['materie'].map((i) => MateriaData.fromJson(i)).toList(),
      formule:
          parsedJson['formule'].map((i) => FormulaData.fromJson(i)).toList(),
    );
  }
}
