import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:formulario/materieManager.dart';
import 'package:formulario/userDrawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'assets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  static const String _title = 'Formulario';
  Assets assets;
  bool assetsLoaded = false;
  Brightness brightness = Brightness.light;
  @override
  void initState() {
    super.initState();
    assets = Assets.instance();
    if (assetsLoaded == false)
      assets.loadMaterie().then((value) => setState(() {
            assetsLoaded = true;
          }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: brightness,
      ),
      title: _title,
      home: Scaffold(
        backgroundColor: Color(0xFFFDEBDF),
        body: Container(
          child: Column(
            children: [
              Image.asset('assets/icons/home.png'),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Expanded(
                  child: AspectRatio(
                    aspectRatio: 6.95,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFF332F2D),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: AutoSizeText(
                        'FORMULARIO',
                        maxLines: 1,
                        minFontSize: 37,
                        style: TextStyle(
                            fontFamily: 'Brandon-Grotesque-black',
                            color: Colors.white,
                            letterSpacing: 2.5,
                            fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70)),
                      color: Color(0xFFC9BBB1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: assetsLoaded
                          ? MaterieManagerWidget(
                              materieData: [
                                assets.getMateriaData('Matematica'),
                                assets.getMateriaData('Fisica'),
                                assets.getMateriaData('Geometria'),
                                assets.getMateriaData('Probabilita')
                              ],
                            )
                          : Text(''),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: UserDrawer(),
      ),
    );
  }
}
