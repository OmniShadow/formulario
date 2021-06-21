import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:formulario/assets.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/formulaData.dart';

// ignore: must_be_immutable

class FormulaWidget extends StatelessWidget {
  final FormulaData formulaData;
  FormulaWidget(this.formulaData);

  //A ogni formula è associato un widget di tipo ExpansionTile che
  //quando espanso mostra una descrizione più approfondita della formula
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        //Icona che quando premuta chiama un metodo per aggiungere o rimuovere la formula dai preferiti
        leading: PreferitiButton(formulaData),
        title: InkWell(
          onTap: () =>
              Navigator.push(context, formulaData.getFormulaMaterialPage()),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            //Widget per la visulizzazione in LaTex della formula dal package flutter_math_fork
            child: Math.tex(formulaData.testo),
          ),
        ),
        subtitle: Text(formulaData.titolo),
        children: [Text(formulaData.descrizione)],
      ),
    );
  }
}

class PreferitiButton extends StatefulWidget {
  final FormulaData formulaData;
  PreferitiButton(this.formulaData);
  @override
  _PreferitiButtonState createState() {
    return _PreferitiButtonState(formulaData);
  }
}

class _PreferitiButtonState extends State<PreferitiButton> {
  FormulaData formulaData;
  _PreferitiButtonState(this.formulaData);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => addToFavourites(context),
      child: Icon(
        (formulaData.isFavourite
            ? Icons.favorite_rounded
            : Icons.favorite_border_rounded),
        color: MyAppColors.shirtColor,
      ),
    );
  }

  void addToFavourites(BuildContext context) {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text((formulaData.isFavourite
            ? 'Formula rimossa dai preferiti'
            : 'Formula aggiunta ai preferiti')),
        duration: Duration(milliseconds: 1000),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(100), bottom: Radius.circular(100))),
      ));
      formulaData.isFavourite = !formulaData.isFavourite;
    });

    Assets.instance!.updatePreferiti(formulaData);
  }
}
