import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:formulario/assets.dart';
import 'package:formulario/constantsUtil.dart';

class MyDrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyDrawerWidgetState();
  }
}

class _MyDrawerWidgetState extends State<MyDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Formulario'),
        ),
        body: ListView(
          children: [
            ProfileDrawerWidget(),
            PreferitiWidget(),
          ],
        ),
      ),
    );
  }
}

class ProfileDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.account_box_rounded),
      title: Text('Profilo'),
      onTap: () {
        //vai al profilo
      },
    );
  }
}

class PreferitiWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PreferitiWidgetState();
  }
}

class _PreferitiWidgetState extends State<PreferitiWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ExpansionTile(
          leading: Icon(Icons.favorite),
          title: Text('Formule preferite'),
          children: widgetPreferiti,
        )
      ],
    );
  }

  List<ListTile> get widgetPreferiti => Assets.instance
      .getFormulePreferite()
      .map((e) => ListTile(
            onLongPress: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Formula rimossa dai preferiti'),
                duration: Duration(milliseconds: 1000),
              ));
              setState(() {
                e.isFavourite = !e.isFavourite;
              });

              Assets.instance.updatePreferiti(e);
            },
            onTap: () => Navigator.push(context, e.getFormulaMaterialPage()),
            leading: Icon(Icons.functions_rounded),
            title: Math.tex(e.testo),
            subtitle: Text(e.titolo),
          ))
      .toList();
}
