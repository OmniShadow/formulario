import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Formula.dart';

// ignore: must_be_immutable
class FormuleManager extends StatelessWidget {
  Set<Formula> formule = Set<Formula>();
  Set<Formula> favFormule = Set<Formula>();
  FormuleManager() {
    //read formule from file
    Future<String> futurefiletxt = loadTxt();

    List<String> filetxt = futurefiletxt.toString().split('\n').toList();

    formule.add(new Formula(filetxt[0], filetxt[1], this));
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: formule.length,
        itemBuilder: (context, index) {
          return formule.elementAt(index);
        });
  }

  Set<Formula> getFavSet() {
    return favFormule;
  }

  Future<String> loadTxt() async {
    return await rootBundle.loadString('assets/logaritmi.txt');
  }
}
