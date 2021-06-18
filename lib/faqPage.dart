import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formulario/assets.dart';

import 'constantsUtil.dart';

class NewPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.appBackground,
      appBar: new AppBar(
        backgroundColor: MyAppColors.appBackground,
        title: Text(
          'Domande frequenti di aiuto teorico',
          style: TextStyle(fontFamily: 'Brandon-Grotesque-black'),
        ),
      ),
      body: ListView.builder(
          itemCount: Assets.instance.faqListMap.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> faq = Assets.instance.faqListMap[index];
            return ExpansionTile(
              title: Text(faq['domanda']),
              children: [Text(faq['risposta'])],
            );
          }),
    );
  }
}

class Nuovo extends StatelessWidget {
  final String title;
  Nuovo(this.title);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: MyAppColors.appBackground,
          appBar: new AppBar(
            title: Text('Risposta'),
            actions: [
              IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (context) => NewPage1());
                  Navigator.push(context, route);
                },
              )
            ],
          ),
          body: Container(
            child: (Text(title)),
          ),
        ),
      ),
    );
  }
}
