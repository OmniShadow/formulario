import 'package:flutter/material.dart';

import 'MateriaWidget.dart';

class MaterieManagerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MaterieManagerState();
  }
}

class _MaterieManagerState extends State<MaterieManagerWidget> {
  List<GridTile> materieWidget;

  List<List<String>> materieNomi = [
    ['Matematica', 'assets/icons/matematica/materia.png'],
    ['Fisica', 'assets/icons/fisica/materia.png'],
    ['Geometria', 'assets/icons/geometria/materia.png'],
    ['Probabilità', 'assets/icons/probabilita/materia.png']
  ];

  Color color = Colors.transparent;

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
        mainAxisSpacing: 10,
      ),
      children: creaMaterie(),
    );
  }

  List<GridTile> creaMaterie() {
    materieWidget = <GridTile>[];
    for (int i = 0; i < 4; i++) {
      materieWidget.add(GridTile(
        footer: AppBar(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 3),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            title: Text(materieNomi[i][0]),
            backgroundColor: Colors.deepOrange.withAlpha(200),
            leading: Icon(Icons.article)),
        child: InkResponse(
          enableFeedback: true,
          child: Container(
            child: MateriaWidget(materieNomi[i][1]),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  color: Colors.black, width: 3, style: BorderStyle.solid),
            ),
          ),
        ),
      ));
    }
    return materieWidget;
  }
}
