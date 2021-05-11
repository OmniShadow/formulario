class FormulaData {
  static int n = 0;
  String titolo;
  String testo;
  List<String> tags;
  String categoria;
  bool isFavourite = false;
  int id;

  FormulaData({this.titolo, this.testo, this.categoria}) {
    id = n++;
  }

  factory FormulaData.fromJson(
      Map<String, dynamic> parsedJson, String categoria) {
    return FormulaData(
      titolo: parsedJson['titolo'],
      testo: parsedJson['testo'],
      categoria: categoria,
    );
  }
}
