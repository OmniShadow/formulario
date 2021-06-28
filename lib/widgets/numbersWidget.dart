import 'package:flutter/material.dart';
import 'package:formulario/assets.dart';
import 'package:formulario/widgets/preferitiWidget.dart';
import 'package:formulario/widgets/recentiWidget.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(
            context,
            (Assets.instance!.formuleRecenti.length +
                    Assets.instance!.materieRecenti.length)
                .toString(),
            'Ricerche',
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RecentiPage()));
            },
          ),
          buildDivider(),
          buildButton(
            context,
            Assets.instance!.formulePreferite.length.toString(),
            'Formule Preferite',
            () {
              Route route =
                  MaterialPageRoute(builder: (context) => PreferitiPage());
              Navigator.push(context, route);
            },
          ),
        ],
      );

  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(
          BuildContext context, String value, String text, Function() f) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: f,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
