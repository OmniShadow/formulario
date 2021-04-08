import 'package:flutter/material.dart';

import 'FormuleManager.dart';

class MateriaWidget extends StatelessWidget {
  Image _iconWidget;
  String materiaTitle;
  MateriaWidget(this.materiaTitle, String iconPath) {
    _iconWidget = Image.asset(iconPath);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text('test'),
                    ),
                    body: FormuleManager())),
          );
        },
        child: GridTile(
          footer: Container(
            alignment: Alignment.center,
            child: Text(
              materiaTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.deepOrange.withAlpha(200),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              border: Border.all(
                  color: Colors.black, width: 3, style: BorderStyle.solid),
            ),
          ),
          child: InkResponse(
            enableFeedback: true,
            child: Container(
              child: _iconWidget,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: Colors.black, width: 3, style: BorderStyle.solid),
              ),
            ),
          ),
        ));
  }
}
