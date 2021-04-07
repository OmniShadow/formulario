import 'package:flutter/material.dart';

class MateriaWidget extends StatelessWidget {
  Image _iconWidget;
  MateriaWidget(String iconPath) {
    _iconWidget = Image.asset(iconPath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 64,
      height: 64,
      child: _iconWidget,
    );
  }
}
