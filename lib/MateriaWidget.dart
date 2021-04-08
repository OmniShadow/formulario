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
    return ListTile(
        enableFeedback: true,
        horizontalTitleGap: 0,
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
        title: GridTile(
          footer: AppBar(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 3),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              title: Text(materiaTitle),
              backgroundColor: Colors.deepOrange.withAlpha(200),
              leading: Icon(Icons.article)),
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
