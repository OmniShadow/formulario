import 'package:flutter/material.dart';
import 'materiaData.dart';
import 'materiaWidget.dart';

class MaterieManagerWidget extends StatefulWidget {
  List<MateriaData> materieData;
  MaterieManagerWidget({this.materieData});
  @override
  State<StatefulWidget> createState() {
    return _MaterieManagerState(materieData);
  }
}

class _MaterieManagerState extends State<MaterieManagerWidget> {
  List<MateriaData> materieData;
  List<MateriaWidget> materieWidget;
  _MaterieManagerState(this.materieData);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: false,
      controller: ScrollController(),
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 60,
        mainAxisSpacing: 30,
      ),
      children: creaMaterie(),
    );
  }

  List<MateriaWidget> creaMaterie() {
    materieWidget = <MateriaWidget>[];
    print('numero materie ' + materieData.length.toString());
    for (MateriaData materiaData in materieData) {
      print('test ' + materiaData.iconPath);
      materieWidget.add(MateriaWidget(materiaData));
    }
    return materieWidget;
  }
}
