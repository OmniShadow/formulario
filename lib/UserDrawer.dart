import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.settings),
          title: Text('Impostazioni utente'),
        ),
      ),
    );
  }
}
