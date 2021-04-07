import 'package:flutter/material.dart';

import 'package:formulario/FormuleManager.dart';

// ignore: must_be_immutable
class Formula extends StatelessWidget {
  final String formulaTitle;
  final String formulaText;
  final FormuleManager manager;
  bool isFavourite = false;
  Formula(this.formulaTitle, this.formulaText, this.manager);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StarIcon(this),
        Column(
          children: [
            Text(formulaText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            // Math.tex(
            //   formulaText,

            // ),
          ],
        )
      ],
    );
  }
}

class StarIcon extends StatefulWidget {
  final Formula _formula;

  StarIcon(this._formula);
  @override
  State<StatefulWidget> createState() {
    return StarIconState(_formula);
  }
}

class StarIconState extends State<StarIcon> {
  Formula _formula;
  Color color;
  StarIconState(this._formula);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          child: Icon(
        Icons.star,
        color: color,
      )),
      onTap: () {
        setState(() {
          if (_formula.isFavourite) {
            color = Colors.grey;
            _formula.isFavourite = false;
            _formula.manager.getFavSet().remove(_formula);
          } else {
            color = Colors.yellow;
            _formula.isFavourite = true;
            _formula.manager.getFavSet().add(_formula);
          }
        });
      },
    );
  }
}
