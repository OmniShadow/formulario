import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulario/MaterieManager.dart';
import 'package:formulario/UserDrawer.dart';
import 'Assets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  static const String _title = 'Formulario';
  Assets assets;
  bool assetsLoaded = false;
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
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple,
      ),
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
          title: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                child: Image.asset('assets/icons/appIcon.png'),
              ),
              Text(
                'Formulario',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 2.5,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: (assetsLoaded
              ? MaterieManagerWidget([
                  assets.getMateriaData('Matematica'),
                  assets.getMateriaData('Fisica'),
                  assets.getMateriaData('Geometria'),
                  assets.getMateriaData('Probabilita'),
                ])
              : Text('')),
        ),
        drawer: UserDrawer(),
      ),
    );
  }
}
