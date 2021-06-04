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
  FormulaData.withId({this.id, this.titolo, this.testo, this.categoria});

  Map<String, dynamic> toMap() => {
        'id': id,
        'titolo': titolo,
        'testo': testo,
        'categoria': categoria,
      };
  FormulaData fromMap(Map<String, dynamic> map) => FormulaData.withId(
        id: map['id'],
        titolo: map['titolo'],
        categoria: map['categoria'],
        testo: map['testo'],
      );

  factory FormulaData.fromJson(
      Map<String, dynamic> parsedJson, String categoria) {
    return FormulaData(
      titolo: parsedJson['titolo'],
      testo: parsedJson['testo'],
      categoria: categoria,
    );
  }
}
