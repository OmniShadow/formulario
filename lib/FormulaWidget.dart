import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter/services.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'assets.dart';
import 'formulaData.dart';

class FormulaWidget extends StatefulWidget {
  final FormulaData formulaData;
  _FormulaState _formulaState;
  FormulaWidget(this.formulaData) {
    _formulaState = _FormulaState(formulaData);
  }
  @override
  State<StatefulWidget> createState() {
    return _formulaState;
  }
}

class _FormulaState extends State<FormulaWidget> {
  FormulaData formulaData;
  _FormulaState(this.formulaData);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () =>
            Navigator.push(context, formulaData.getFormulaMaterialPage()),
        enableFeedback: true,
        trailing: GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: formulaData.testo));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Formula copiata'),
              duration: Duration(milliseconds: 500),
            ));
          },
          child: Icon(
            Icons.copy,
          ),
        ),
        enabled: true,
        hoverColor: Colors.red.withAlpha(150),
        onLongPress: () => addToFavourites(context),
        leading: GestureDetector(
          onTap: () => addToFavourites(context),
          child: Icon(
            (formulaData.isFavourite ? Icons.favorite : Icons.favorite_border),
            color: MyAppColors.shirtColor,
          ),
        ),
        title: Column(
          children: [
            Wrap(
              children: [Math.tex(formulaData.testo)],
            ),
          ],
        ),
        subtitle: Text(formulaData.titolo),
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
    Assets.instance.aggiungiFormulaPreferiti(formulaData);
  }
}
