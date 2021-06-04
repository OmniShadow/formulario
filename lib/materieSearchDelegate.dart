import 'package:flutter/material.dart';
import 'package:formulario/formulaData.dart';
import 'package:formulario/materiaData.dart';

import 'assets.dart';

class MaterieSearch extends SearchDelegate<MateriaData> {
  List<MateriaData> materieData;
  List<MateriaData> materieRecenti = [];

  MaterieSearch() {
    materieData = [
      Assets.instance.getMateriaData('Matematica'),
      Assets.instance.getMateriaData('Fisica'),
      Assets.instance.getMateriaData('Geometria'),
      Assets.instance.getMateriaData('Probabilita'),
    ];
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
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
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  List<MateriaData> creaListaSuggerimenti(List<MateriaData> materieData) {
    List<MateriaData> suggerimenti = materieData
        .where((materia) =>
            materia.materiaTitle.toLowerCase().contains(query.toLowerCase()) ||
            materia.categoria.toLowerCase().contains(query.toLowerCase()))
        .toList();
    for (MateriaData materia in materieData)
      suggerimenti.addAll(creaListaSuggerimenti(materia.subMaterie));
    return suggerimenti;
  }

  List<FormulaData> creaListSuggerimentiFormule(List<MateriaData> materieData) {
    List<FormulaData> suggerimenti = [];
    for (MateriaData materia in materieData)
      suggerimenti.addAll(materia.formule
          .where((formula) =>
              formula.categoria.toLowerCase().contains(query.toLowerCase()) ||
              formula.titolo.toLowerCase().contains(query.toLowerCase()))
          .toList());
    for (MateriaData materia in materieData)
      suggerimenti.addAll(creaListSuggerimentiFormule(materia.subMaterie));
    return suggerimenti;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<MateriaData> suggerimenti =
        query.isEmpty ? materieRecenti : creaListaSuggerimenti(materieData);
    List<FormulaData> suggerimentiFormule =
        query.isEmpty ? [] : creaListSuggerimentiFormule(materieData);
    return ListView.builder(
      itemCount: suggerimenti.length + suggerimentiFormule.length,
      itemBuilder: (context, index) {
        if (index < suggerimenti.length)
          return ListTile(
            onTap: () {
              materieRecenti.add(suggerimenti[index]);
            },
            leading: Icon(Icons.menu_book_rounded),
            trailing: query.isEmpty ? Icon(Icons.history) : Text(''),
            title: RichText(
              text: TextSpan(
                children:
                    highlightOccurrences(suggerimenti[index].categoria, query),
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        else
          return ListTile(
            onTap: () {},
            leading: Icon(Icons.functions),
            trailing: query.isEmpty ? Icon(Icons.history) : Text(''),
            title: RichText(
              text: TextSpan(
                children: highlightOccurrences(
                    suggerimentiFormule[index - suggerimenti.length].titolo,
                    query),
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
      },
    );
  }

  //taken from stackOverflow
  List<TextSpan> highlightOccurrences(String source, String query) {
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
