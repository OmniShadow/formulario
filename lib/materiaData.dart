import 'package:flutter/material.dart';
import 'package:formulario/assets.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/formulaData.dart';
import 'package:formulario/formuleManager.dart';
import 'package:formulario/materieManager.dart';

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

  //Metodo per ottenere tutte le sottomaterie
  List<MateriaData> getMaterie() {
    List<MateriaData> materie = [];
    materie.addAll(subMaterie);
    for (MateriaData subMateria in subMaterie)
      materie.addAll(subMateria.getMaterie());
    return materie;
  }

  //Metodo per ottenere tutte le formule comprese quelle delle sottomaterie
  List<FormulaData> getFormule() {
    List<FormulaData> formuleAll = [];
    formuleAll.addAll(formule);
    List<MateriaData> materie = getMaterie();
    for (MateriaData materia in materie) {
      formuleAll.addAll(materia.getFormule());
    }
    return formuleAll;
  }

  String toString() {
    return (materiaTitle);
  }

  //Metodo ricorsivo per istanziare un oggetto MateriaData da un file .json
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
      _subMaterie = materieJson
          .map((materiaJson) => MateriaData.fromJson(materiaJson, categoria))
          .toList();
      for (dynamic _subMateria in _subMaterie) {
        subMaterieData.add(_subMateria as MateriaData);
      }
    } else {
      subMaterieData = [];
    }
    formuleJson = parsedJson['formule'];

    if (!formuleJson.isEmpty) {
      _formule = formuleJson
          .map((formulaJson) => FormulaData.fromJson(formulaJson, categoria))
          .toList();
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

  //Metodo per ottenere la pagina associata alle sottomaterie o alle formule di questa materia
  MaterialPageRoute getMateriaPage() {
    Assets.instance.updateMaterieRecenti(this);
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: MyAppColors.appBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: MyAppColors.iconColor,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 6.95,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: AspectRatio(
                  aspectRatio: 6.95,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: MyAppColors.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: materiaTitle,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Image.asset(iconPath),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            materiaTitle,
                            style: TextStyle(
                              fontFamily: 'Brandon-Grotesque-black',
                              color: Colors.white,
                              letterSpacing: 2.5,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            (formule.isEmpty
                ? Expanded(
                    flex: 8,
                    child: Container(
                      child: MaterieManagerWidget(materieData: subMaterie),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(70)),
                        color: MyAppColors.materieBackground,
                      ),
                    ),
                  )
                : Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: FormuleManager(
                        formule: formule,
                      ),
                    ),
                  )),
            MaterialButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              child: Icon(
                Icons.home_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
