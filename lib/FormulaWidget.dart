import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter/services.dart';

class FormulaWidget extends StatefulWidget {
  String formulaTitle;
  String formulaText;
  FormulaWidget(this.formulaTitle, this.formulaText);
  @override
  State<StatefulWidget> createState() {
    return _FormulaState(formulaTitle, formulaText);
  }
}

class _FormulaState extends State<FormulaWidget> {
  final String formulaTitle;
  final String formulaText;
  bool isFavourite = false;
  _FormulaState(this.formulaTitle, this.formulaText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          enableFeedback: true,
          trailing: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: formulaText));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Formula copiata'),
                duration: Duration(milliseconds: 500),
              ));
            },
            child: Icon(Icons.copy),
          ),
          enabled: true,
          hoverColor: Colors.red.withAlpha(150),
          onLongPress: () {
            setState(() {
              Clipboard.setData(ClipboardData(text: formulaText));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text((isFavourite
                    ? 'Formula rimossa dai preferiti'
                    : 'Formula aggiunta ai preferiti')),
                duration: Duration(milliseconds: 1000),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(100),
                        bottom: Radius.circular(100))),
              ));
              isFavourite = !isFavourite;
            });
          },
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text(formulaTitle),
                      ),
                      body: Column(
                        children: [
                          FittedBox(
                            child: Card(
                              child: Math.tex(
                                formulaText,
                                textScaleFactor: 5.0,
                              ),
                            ),
                          ),
                        ],
                      )),
                ));
          },
          leading: Icon(
            (isFavourite ? Icons.star : Icons.star_border),
            color: Colors.yellow,
          ),
          title: Math.tex(formulaText),
          subtitle: Text(formulaTitle),
        ),
      ),
    );
  }
}
