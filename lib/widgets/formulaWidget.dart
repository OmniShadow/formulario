import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:formulario/assets.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/formulaData.dart';

class FormulaWidget extends StatefulWidget {
  final FormulaData formulaData;
  FormulaWidget({
    Key? key,
    required this.formulaData,
  }) : super(key: key);

  @override
  _FormulaWidgetState createState() => _FormulaWidgetState();
}

class _FormulaWidgetState extends State<FormulaWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      initiallyExpanded: false,
      //Icona che quando premuta chiama un metodo per aggiungere o rimuovere la formula dai preferiti
      leading: InkWell(
        onTap: () => addToFavourites(context),
        child: Icon(
          (widget.formulaData.isFavourite
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded),
          color: MyAppColors.shirtColor,
        ),
      ),
      title: InkWell(
        onTap: () => Navigator.push(
            context, widget.formulaData.getFormulaMaterialPage()),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          //Widget per la visulizzazione in LaTex della formula dal package flutter_math_fork
          child: Math.tex(widget.formulaData.testo),
        ),
      ),
      subtitle: Text(widget.formulaData.titolo),
      children: [
        ListTile(
          title: Text(widget.formulaData.descrizione),
        ),
      ],
    );
  }

// class PreferitiButton extends StatefulWidget {
//   final FormulaData formulaData;
//   PreferitiButton(this.formulaData);
//   @override
//   _PreferitiButtonState createState() {
//     return _PreferitiButtonState(formulaData);
//   }
// }

// class _PreferitiButtonState extends State<PreferitiButton> {
//   FormulaData formulaData;
//   _PreferitiButtonState(this.formulaData);
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => addToFavourites(context),
//       child: Icon(
//         (formulaData.isFavourite
//             ? Icons.favorite_rounded
//             : Icons.favorite_border_rounded),
//         color: MyAppColors.shirtColor,
//       ),
//     );
//   }

  void addToFavourites(BuildContext context) {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text((widget.formulaData.isFavourite
            ? 'Formula rimossa dai preferiti'
            : 'Formula aggiunta ai preferiti')),
        duration: Duration(milliseconds: 1000),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(100), bottom: Radius.circular(100))),
      ));
      widget.formulaData.isFavourite = !widget.formulaData.isFavourite;
    });

    Assets.instance!.updatePreferiti(widget.formulaData);
  }
}

// // ignore: must_be_immutable
// class FormulaWidget extends StatefulWidget {
//   final FormulaData formulaData;
//   _FormulaState? _formulaState;
//   FormulaWidget(
//     this.formulaData,
//   ) {
//     _formulaState = _FormulaState(formulaData);
//   }
//   @override
//   _FormulaState createState() {
//     return _formulaState!;
//   }
// }

// class _FormulaState extends State<FormulaWidget> {
//   FormulaData formulaData;
//   _FormulaState(this.formulaData);

//   //A ogni formula è associato un widget di tipo ExpansionTile che
//   //quando espanso mostra una descrizione più approfondita della formula
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ExpansionTile(
//         initiallyExpanded: false,
//         //Icona che quando premuta chiama un metodo per aggiungere o rimuovere la formula dai preferiti
//         leading: InkWell(
//           onTap: () => addToFavourites(context),
//           child: Icon(
//             (formulaData.isFavourite
//                 ? Icons.favorite_rounded
//                 : Icons.favorite_border_rounded),
//             color: MyAppColors.shirtColor,
//           ),
//         ),
//         title: InkWell(
//           onTap: () =>
//               Navigator.push(context, formulaData.getFormulaMaterialPage()),
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             alignment: Alignment.centerLeft,
//             //Widget per la visulizzazione in LaTex della formula dal package flutter_math_fork
//             child: Math.tex(formulaData.testo),
//           ),
//         ),
//         subtitle: Text(formulaData.titolo),
//         children: [
//           ListTile(
//             title: Text(formulaData.descrizione),
//           ),
//         ],
//       ),
//     );
//   }

  
// }
