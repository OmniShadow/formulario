import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter/services.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'assets.dart';
import 'formulaData.dart';
import 'package:animations/animations.dart';

class FormulaWidget extends StatefulWidget {
  FormulaData formulaData;
  FormulaWidget(this.formulaData);
  @override
  State<StatefulWidget> createState() {
    return _FormulaState(formulaData);
  }
}

class _FormulaState extends State<FormulaWidget> {
  FormulaData formulaData;
  _FormulaState(this.formulaData);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(closedBuilder: (context, action) {
      return Card(
        child: ListTile(
          onTap: action,
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
              (formulaData.isFavourite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: MyAppColors.shirtColor,
            ),
          ),
          title: Math.tex(formulaData.testo),
          subtitle: Text(formulaData.titolo),
        ),
      );
    }, openBuilder: (context, action) {
      return Scaffold(
          appBar: AppBar(
            title: Text(formulaData.titolo),
          ),
          body: Column(
            children: [
              FittedBox(
                child: Card(
                  child: Math.tex(
                    formulaData.testo,
                    textScaleFactor: 7.0,
                  ),
                ),
              ),
              WebView(
                initialUrl: 'google.it',
              ),
            ],
          ));
    });
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
    Assets.instance().aggiungiFormulaPreferiti(formulaData);
  }
}
