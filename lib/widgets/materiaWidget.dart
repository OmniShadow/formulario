import 'package:flutter/material.dart';
import 'package:formulario/materiaData.dart';

class MateriaWidget extends StatefulWidget {
  int tag = 0;
  final MateriaData materiaData;
  MateriaWidget(this.materiaData);
  @override
  _MateriaWidgetState createState() {
    return _MateriaWidgetState(materiaData, tag);
  }

  void setTag(int tag) {
    this.tag = tag;
    materiaData.setTag(tag);
  }
}

class _MateriaWidgetState extends State<MateriaWidget> {
  MateriaData materiaData;
  int tag;
  Image? _iconWidget;
  _MateriaWidgetState(this.materiaData, this.tag) {
    _iconWidget = Image.asset(materiaData.iconPath);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Ink(
          child: Column(
            children: [
              materiaBoxWidget,
              materiaTitleWidget,
            ],
          ),
        ),
        onTap: () {
          if (!(materiaData.formule.isEmpty && materiaData.subMaterie.isEmpty))
            Navigator.push(context, materiaData.getMateriaPage());
        },
      ),
    );
  }

  Widget get materiaBoxWidget => Expanded(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(materiaData.colorValue),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFF1E5DD).withAlpha(100),
                  offset: Offset(-20, 10),
                ),
                BoxShadow(
                  color: Color(0xFFF1E5DD).withAlpha(100),
                  offset: Offset(-20, 0),
                ),
                BoxShadow(
                  color: Color(0xFFF1E5DD).withAlpha(100),
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Hero(
                tag: '$tag',
                child: _iconWidget!,
              ),
            ),
          ),
        ),
      );
  Widget get materiaTitleWidget => Padding(
        padding: EdgeInsets.only(top: 7),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            materiaData.materiaTitle.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Brandon-Grotesque-black',
              letterSpacing: 0.2,
              shadows: [
                Shadow(
                  color: Colors.grey[600]!,
                  offset: Offset(-3, 0),
                ),
              ],
              color: Colors.white,
            ),
          ),
        ),
      );
}
