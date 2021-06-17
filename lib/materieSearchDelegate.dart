import 'package:flutter/material.dart';
import 'package:formulario/assets.dart';
import 'package:formulario/formulaData.dart';
import 'package:formulario/materiaData.dart';

class MaterieSearch extends SearchDelegate<MateriaData> {
  static MaterieSearch _materieSearch;
  List<MateriaData> materieData;
  List<MateriaData> materieRecenti = [];
  List<FormulaData> formuleRecenti = [];

  MaterieSearch._() {
    materieData = [
      Assets.instance.getMateriaData('Matematica'),
      Assets.instance.getMateriaData('Fisica'),
      Assets.instance.getMateriaData('Geometria'),
      Assets.instance.getMateriaData('Probabilita'),
    ];
  }

  static MaterieSearch get instance => ((_materieSearch == null)
      ? _materieSearch = MaterieSearch._()
      : _materieSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear_rounded),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<MateriaData> suggerimenti = query.isEmpty
        ? Assets.instance.materieRecenti
        : _creaListaSuggerimenti(materieData);
    List<FormulaData> suggerimentiFormule = query.isEmpty
        ? Assets.instance.formuleRecenti
        : _creaListSuggerimentiFormule(materieData);
    return (suggerimenti.isEmpty &
            suggerimentiFormule.isEmpty &
            query.isNotEmpty)
        ? trovatoNullaWidget
        : ListView.builder(
            itemCount: suggerimenti.length + suggerimentiFormule.length,
            itemBuilder: (context, index) {
              if (index < suggerimenti.length)
                return materiaSuggeritaTile(
                    suggerimenti[index], context, query.isEmpty, true);
              else
                return formulaSuggeriteTile(
                    suggerimentiFormule[index - suggerimenti.length],
                    context,
                    query.isEmpty,
                    true);
            },
          );
  }

  Widget get trovatoNullaWidget => Center(
        child: Container(
          child: Column(
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 100,
                color: Colors.grey.withAlpha(100),
              ),
              Text(
                'Nessun risultato trovato',
                style: TextStyle(
                  fontFamily: 'Brandon-Grotesque-black',
                  color: Colors.grey.withAlpha(100),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      );

  Widget materiaSuggeritaTile(
      MateriaData materiaData, context, bool recente, bool highlight) {
    return ListTile(
      onTap: () {
        Assets.instance.updateMaterieRecenti(materiaData);
        Navigator.push(context, materiaData.getMateriaPage());
      },
      leading: Icon(Icons.menu_book_rounded),
      title: highlight
          ? RichText(
              text: TextSpan(
                children:
                    _highlightOccurrences(materiaData.materiaTitle, query),
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Text(
              materiaData.materiaTitle,
              style: TextStyle(color: Colors.grey),
            ),
      subtitle: highlight
          ? RichText(
              text: TextSpan(
                children: _highlightOccurrences(materiaData.categoria, query),
                style: TextStyle(color: Colors.blueGrey),
              ),
            )
          : Text(
              materiaData.categoria.replaceAll(materiaData.materiaTitle, ''),
              style: TextStyle(color: Colors.blueGrey),
            ),
      trailing: recente ? Icon(Icons.history_rounded) : null,
    );
  }

  ListTile formulaSuggeriteTile(
      FormulaData formulaData, context, bool recente, bool highlight) {
    return ListTile(
      onTap: () {
        Assets.instance.updateFormuleRecenti(formulaData);
        Navigator.push(context, formulaData.getFormulaMaterialPage());
      },
      leading: Icon(Icons.functions_rounded),
      title: highlight
          ? RichText(
              text: TextSpan(
                children: _highlightOccurrences(formulaData.titolo, query),
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Text(
              formulaData.titolo,
              style: TextStyle(color: Colors.grey),
            ),
      subtitle: highlight
          ? RichText(
              text: TextSpan(
                children: _highlightOccurrences(formulaData.categoria, query),
                style: TextStyle(color: Colors.blueGrey),
              ),
            )
          : Text(
              formulaData.categoria,
              style: TextStyle(color: Colors.blueGrey),
            ),
      trailing: query.isEmpty ? Icon(Icons.history_rounded) : null,
    );
  }

  List<MateriaData> _creaListaSuggerimenti(List<MateriaData> materieData) {
    List<MateriaData> suggerimenti = materieData
        .where((materia) =>
            materia.materiaTitle.toLowerCase().contains(query.toLowerCase()) ||
            materia.categoria.toLowerCase().contains(query.toLowerCase()))
        .toList();
    for (MateriaData materia in materieData)
      suggerimenti.addAll(_creaListaSuggerimenti(materia.subMaterie));
    return suggerimenti;
  }

  List<FormulaData> _creaListSuggerimentiFormule(
      List<MateriaData> materieData) {
    List<FormulaData> suggerimenti = [];
    for (MateriaData materia in materieData)
      suggerimenti.addAll(materia.formule
          .where((formula) =>
              formula.categoria.toLowerCase().contains(query.toLowerCase()) ||
              formula.titolo.toLowerCase().contains(query.toLowerCase()))
          .toList());
    for (MateriaData materia in materieData)
      suggerimenti.addAll(_creaListSuggerimentiFormule(materia.subMaterie));
    return suggerimenti;
  }

  //taken from stackOverflow
  List<TextSpan> _highlightOccurrences(String source, String query) {
    if (query == null ||
        query.isEmpty ||
        !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));
      }

      children.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ));

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
        ));
      }
      lastMatchEnd = match.end;
    }
    return children;
  }
}
