import 'package:flutter/material.dart';
import 'package:formulario/widgets/formulaWidget.dart';
import 'formulaData.dart';

class FormuleManager extends StatelessWidget {
  final List<FormulaData> formule;

  FormuleManager({required this.formule});

  @override
  Widget build(BuildContext context) {
    List<FormulaWidget> formuleWidgets = formule.map((e) {
      return FormulaWidget(formulaData: e);
    }).toList();
    // for (FormulaData formula in formule) {
    //   formuleWidgets.add(FormulaWidget(formula));
    // }
    return ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: formuleWidgets.length,
      itemBuilder: (context, index) {
        print("index:$index");
        return formuleWidgets[index];
      },
    );
  }
}
