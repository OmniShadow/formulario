import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:formulario/assets.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/materieSearchDelegate.dart';
import 'package:formulario/widgets/formulaWidget.dart';
import 'package:formulario/widgets/materiaWidget.dart';

class RecentiWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecentiWidgetState();
  }
}

class _RecentiWidgetState extends State<RecentiWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> recenti = recentiWidget(context);
    return ExpansionTile(
      childrenPadding: EdgeInsets.only(left: 20),
      initiallyExpanded: false,
      leading: Icon(
        Icons.history,
        color: Colors.grey,
      ),
      title: InkWell(
        onTap: () => Navigator.push(
          context,
          recentiPage,
        ),
        child: Text(
          'Recenti',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
      ),
      trailing: InkWell(
        onTap: () => setState(() {
          Assets.instance.clearRecenti();
        }),
        child: Icon(
          Icons.delete_rounded,
          color: Colors.grey,
        ),
      ),
      children: recenti.isEmpty
          ? [
              ListTile(
                title: Text(
                  'Non ci sono dati recenti',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ]
          : recenti,
    );
  }

  MaterialPageRoute get recentiPage {
    List<Widget> recenti = [];
    recenti.addAll(Assets.instance.materieRecenti.map((e) {
      MateriaWidgetState materiaWidgetState = MateriaWidget(e).createState();
      return Card(
        child: ListTile(
          leading: materiaWidgetState.materiaBoxWidget,
          title: Text(
            e.materiaTitle,
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            e.categoria,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      );
    }).toList());

    recenti.addAll(Assets.instance.formuleRecenti.map((e) {
      return FormulaWidget(e);
    }).toList());

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
                            Icons.history_rounded,
                            color: MyAppColors.materieBackground,
                          ),
                          AutoSizeText(
                            'Recenti',
                            maxLines: 1,
                            minFontSize: 1,
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
                flex: 1,
                child: recenti.isEmpty
                    ? MaterieSearch.instance.trovatoNullaWidget
                    : ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: recenti.length,
                        itemBuilder: (context, index) {
                          return recenti[index];
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> recentiWidget(context) {
    List<Widget> recenti = _getMaterieRecentiWidget(context);
    recenti.addAll(_getFormuleRecentiWidget(context));
    return recenti;
  }

  List<Widget> _getMaterieRecentiWidget(context) =>
      Assets.instance.materieRecenti
          .map(
            (materia) => MaterieSearch.instance
                .materiaSuggeritaTile(materia, context, true, false),
          )
          .toList();
  List<Widget> _getFormuleRecentiWidget(context) =>
      Assets.instance.formuleRecenti
          .map(
            (formula) => MaterieSearch.instance
                .formulaSuggeriteTile(formula, context, true, false),
          )
          .toList();
}
