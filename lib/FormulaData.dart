class FormulaData {
  String titolo;
  String testo;
  List<String> tags;
  bool isFavourite = false;

  FormulaData({this.titolo, this.testo});

  factory FormulaData.fromJson(Map<String, dynamic> parsedJson) {
    return FormulaData(
      titolo: parsedJson['titolo'],
      testo: parsedJson['testo'],
    );
  }
}
