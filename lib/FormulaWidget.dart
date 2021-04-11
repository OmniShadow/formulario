import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter/services.dart';
import 'formulaData.dart';

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
    return Container(
      child: Card(
        child: ListTile(
          enableFeedback: true,
          trailing: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: formulaData.testo));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Formula copiata'),
                duration: Duration(milliseconds: 500),
              ));
            },
            child: Icon(Icons.copy),
          ),
          enabled: true,
          hoverColor: Colors.red.withAlpha(150),
          onLongPress: () => addToFavourites(context),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
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
                        ],
                      )),
                ));
          },
          leading: GestureDetector(
            onTap: () => addToFavourites(context),
            child: Icon(
              (formulaData.isFavourite ? Icons.star : Icons.star_border),
              color: Colors.yellow,
            ),
          ),
          title: Math.tex(formulaData.testo),
          subtitle: Text(formulaData.titolo),
        ),
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
  }
}
