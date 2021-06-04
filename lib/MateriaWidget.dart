import 'package:flutter/material.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/formuleManager.dart';
import 'materiaData.dart';
import 'materieManager.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MateriaWidget extends StatefulWidget {
  final MateriaData materiaData;
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
                flex: 1,
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
                    wrapWords: false,
                    minFontSize: 5,
                    maxFontSize: 100,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Brandon-Grotesque-black',
                      letterSpacing: 0.2,
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
          if (!(materiaData.formule.isEmpty && materiaData.subMaterie.isEmpty))
            Navigator.push(context, getMateriaPage());
        },
      ),
    );
  }

  MaterialPageRoute getMateriaPage() {
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
                        color: Color(0xFF332F2D),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: materiaData.materiaTitle,
                          child: Image.asset(materiaData.iconPath),
                        ),
                        AutoSizeText(
                          materiaData.materiaTitle,
                          maxLines: 1,
                          minFontSize: 1,
                          style: TextStyle(
                              fontFamily: 'Brandon-Grotesque-black',
                              color: Colors.white,
                              letterSpacing: 2.5,
                              fontStyle: FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            (materiaData.formule.isEmpty
                ? Expanded(
                    flex: 8,
                    child: Container(
                      child: MaterieManagerWidget(
                          materieData: materiaData.subMaterie),
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
                    child: FormuleManager(
                      formule: materiaData.formule,
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
