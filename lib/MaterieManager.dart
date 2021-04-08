import 'package:flutter/material.dart';
import 'package:formulario/FormuleManager.dart';

import 'MateriaWidget.dart';

class MaterieManagerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MaterieManagerState();
  }
}

class _MaterieManagerState extends State<MaterieManagerWidget> {
  List<MateriaWidget> materieWidget;

  List<List<String>> materieNomi = [
    ['Matematica', 'assets/icons/matematica/materia.png'],
    ['Fisica', 'assets/icons/fisica/materia.png'],
    ['Geometria', 'assets/icons/geometria/materia.png'],
    ['Probabilità', 'assets/icons/probabilita/materia.png']
  ];
  @override
  Widget build(BuildContext context) {
    return GridView(
      controller: ScrollController(),
      physics: ScrollPhysics(),
      padding: EdgeInsets.all(0.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 1,
      ),
      children: creaMaterie(),
    );
  }

  List<MateriaWidget> creaMaterie() {
    materieWidget = <MateriaWidget>[];
    for (int i = 0; i < 4; i++) {
      materieWidget.add(MateriaWidget(materieNomi[i][0], materieNomi[i][1]));
    }
    return materieWidget;
  }
}
