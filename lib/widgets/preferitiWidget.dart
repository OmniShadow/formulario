import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:formulario/assets.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/formuleManager.dart';

class PreferitiWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PreferitiWidgetState();
  }
}

class _PreferitiWidgetState extends State<PreferitiWidget> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.only(left: 20),
      initiallyExpanded: expanded,
      onExpansionChanged: (e) {
        setState(() {
          expanded = !expanded;
        });
      },
      leading: Icon(
        Icons.favorite_rounded,
        color: MyAppColors.shirtColor,
      ),
      title: InkWell(
        onTap: () => Navigator.push(context, formulePreferitePage),
        child: Text(
          'Formule preferite',
          style: TextStyle(fontSize: 20),
        ),
      ),
      children: widgetPreferiti,
    );
  }

  //Nel caso in cui non ci fossero delle formule tra i preferiti comparirà una
  List<Widget> get widgetPreferiti {
    return Assets.instance!.formulePreferite.isEmpty
        ? [
            ListTile(
              title: Text(
                'Non hai formule tra i preferiti',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ]
        : Assets.instance!.formulePreferite
            .map(
              (e) => ListTile(
                onLongPress: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Formula rimossa dai preferiti'),
                    duration: Duration(milliseconds: 1000),
                  ));
                  setState(() {
                    e.isFavourite = !e.isFavourite;
                  });

                  Assets.instance!.updatePreferiti(e);
                },
                onTap: () =>
                    Navigator.push(context, e.getFormulaMaterialPage()),
                leading: Icon(Icons.functions_rounded),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Math.tex(e.testo),
                ),
                subtitle: Text(e.titolo),
              ),
            )
            .toList();
  }

  MaterialPageRoute get formulePreferitePage {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        backgroundColor: MyAppColors.appBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: MyAppColors.iconColor,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 6.95,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: AspectRatio(
                    aspectRatio: 6.95,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFF332F2D),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_rounded,
                            color: MyAppColors.shirtColor,
                          ),
                          Text(
                            'Formule preferite',
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: 'Brandon-Grotesque-black',
                                color: Colors.white,
                                letterSpacing: 2.5,
                                fontStyle: FontStyle.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Assets.instance!.formulePreferite.isEmpty
                    ? paginaVuotaPreferiti()
                    : FormuleManager(
                        formule: Assets.instance!.formulePreferite,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paginaVuotaPreferiti() {
    return SizedBox(
      height: 200,
      child: Container(
        child: Column(
          children: [
            Icon(
              Icons.favorite_outline_rounded,
              size: 200,
              color: Colors.grey.withAlpha(100),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Non hai formule tra i preferiti \n usa l\'icona',
                    style: TextStyle(
                      fontFamily: 'Brandon-Grotesque-black',
                      color: Colors.grey.withAlpha(100),
                      fontSize: 20,
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.favorite_outline_rounded,
                      color: MyAppColors.shirtColor,
                    ),
                  ),
                  TextSpan(
                    text: 'per aggiungerne',
                    style: TextStyle(
                      fontFamily: 'Brandon-Grotesque-black',
                      color: Colors.grey.withAlpha(100),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
