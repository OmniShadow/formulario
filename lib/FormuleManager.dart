import 'package:flutter/material.dart';
import 'FormulaWidget.dart';

// ignore: must_be_immutable
class FormuleManager extends StatelessWidget {
  List<List<String>> dummy = [
    [
      'test formula',
      r'\hat f(\xi) = \int_{-\infty}^\infty f(x)e^{- 2\pi i \xi x}\mathrm{d}x'
    ],
    ['test formula', r'x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
    ['test formula', r'\frac a b'],
  ];
  @override
  Widget build(BuildContext context) {
    List<FormulaWidget> formule = [];
    for (List<String> e in dummy) {
      formule.add(FormulaWidget(e[0], e[1]));
    }
    return ListView(
      children: formule,
    );
  }
}
