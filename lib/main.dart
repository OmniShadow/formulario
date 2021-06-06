import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/materieManager.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:formulario/myDrawerWidget.dart';
import 'assets.dart';
import 'materieSearchDelegate.dart';

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
  Assets assets = Assets.instance;
  Future assetsFuture;
  bool assetsLoaded = false;
  Brightness brightness = Brightness.light;
  @override
  void initState() {
    super.initState();
    assetsFuture = assets.loadMaterie();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: MyAppColors.iconColor,
        brightness: brightness,
        primaryColor: MyAppColors.appBackground,
      ),
      title: _title,
      home: FutureBuilder(
          future: assetsFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return LoadingScreen();
              case ConnectionState.done:
                assets.loadFormule();
                return _MyHomePage();
              default:
                return LoadingScreen();
            }
          }),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xFF332F2D),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MaterieSearch.instance);
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFFDEBDF),
      body: _MyHomePageBody(),
      drawer: MyDrawerWidget(),
    );
  }
}

class _MyHomePageBody extends StatelessWidget {
  _MyHomePageBody();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Hero(
              tag: 'immagineFormulario',
              child: Image.asset('assets/icons/home.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
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
                  padding: EdgeInsets.all(0),
                  child: materieHomePage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get materieHomePage => MaterieManagerWidget(
        materieData: [
          Assets.instance.getMateriaData('Matematica'),
          Assets.instance.getMateriaData('Fisica'),
          Assets.instance.getMateriaData('Geometria'),
          Assets.instance.getMateriaData('Probabilita')
        ],
      );
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDEBDF),
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset('assets/icons/home.png'),
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 6.95,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xFF332F2D),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF332F2D)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
