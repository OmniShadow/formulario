import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:formulario/MaterieManager.dart';
import 'package:formulario/UserDrawer.dart';
import 'Assets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Formulario';

  @override
  Widget build(BuildContext context) {
    print(Assets.instance());
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
          child: MaterieManagerWidget([
            Assets.instance().getMateriaData('matematica'),
            Assets.instance().getMateriaData('fisica'),
            Assets.instance().getMateriaData('geometria'),
            Assets.instance().getMateriaData('probabilita'),
          ]),
          // child: FormuleManager(),
        ),
        drawer: UserDrawer(),
      ),
    );
  }
}
