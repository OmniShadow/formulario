import 'dart:collection';

import 'FormulaData.dart';

class Assets {
  HashMap<String, List<FormulaData>> formuleDataMap;
  Assets _assets;
  Assets instance() => (_assets == null ? _assets = Assets._() : _assets);
  Assets._() {}
}
