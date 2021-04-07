import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formulario/FormuleManager.dart';
import 'package:formulario/MaterieManager.dart';
import 'package:formulario/UserDrawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Formulario';

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
          child: MaterieManagerWidget(),
        ),
        drawer: UserDrawer(),
      ),
    );
  }
}
