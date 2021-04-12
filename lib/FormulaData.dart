class FormulaData {
  String titolo;
  String testo;
  List<String> tags;
  String categoria;
  bool isFavourite = false;

  FormulaData({this.titolo, this.testo, this.categoria});

  factory FormulaData.fromJson(
      Map<String, dynamic> parsedJson, String categoria) {
    return FormulaData(
      titolo: parsedJson['titolo'],
      testo: parsedJson['testo'],
      categoria: categoria,
    );
  }
}
