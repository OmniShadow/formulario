import 'package:flutter/material.dart';
import 'package:formulario/formuleManager.dart';
import 'materiaData.dart';
import 'materieManager.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MateriaWidget extends StatefulWidget {
  MateriaData materiaData;
  MateriaWidget(this.materiaData);
  @override
  State<StatefulWidget> createState() {
    return MateriaWidgetState(materiaData);
  }
}

class MateriaWidgetState extends State<MateriaWidget> {
  MateriaData materiaData;
  Image _iconWidget;
  MateriaWidgetState(this.materiaData) {
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
              Expanded(
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
                        tag: materiaData.materiaTitle,
                        child: _iconWidget,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 7),
                child: Container(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    materiaData.materiaTitle.toUpperCase(),
                    maxFontSize: 100,
                    minFontSize: 20,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Brandon-Grotesque-black',
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.grey[600],
                          offset: Offset(-3, 0),
                        ),
                      ],
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          if (materiaData.formule.isEmpty && materiaData.subMaterie.isEmpty) {
          } else
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  backgroundColor: Color(0xFFFDEBDF),
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: Color(0xFF332F2D),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Hero(
                              tag: materiaData.materiaTitle,
                              child: _iconWidget,
                            ),
                          ),
                          Text(materiaData.materiaTitle),
                        ],
                      ),
                      (materiaData.formule.isEmpty
                          ? Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(70),
                                      topRight: Radius.circular(70)),
                                  color: Color(0xFFC9BBB1),
                                ),
                                child: Expanded(
                                  child: MaterieManagerWidget(
                                      materieData: materiaData.subMaterie),
                                ),
                              ),
                            )
                          : Expanded(
                              child: FormuleManager(
                                formule: materiaData.formule,
                              ),
                            )),
                    ],
                  ),
                ),
              ),
            );
        },
      ),
    );
  }

  void addToFavourites(BuildContext context) {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text((materiaData.isFavourite
            ? 'Materia rimossa dai preferiti'
            : 'Materia aggiunta ai preferiti')),
        duration: Duration(milliseconds: 1000),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(100), bottom: Radius.circular(100))),
      ));
      materiaData.isFavourite = !materiaData.isFavourite;
    });
  }
}
