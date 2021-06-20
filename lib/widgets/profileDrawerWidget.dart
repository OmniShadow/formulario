//Una volta cliccato sul nostro profilo apparirà il nome utente, email e le cose da fare, ovvero tutto ciò
//che viene inserito dall'utente nel proprio profilo
import 'package:flutter/material.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/profilePage.dart';

class ProfileDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.account_box_rounded,
        color: MyAppColors.iconColor,
      ),
      title: Text(
        'Profilo',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      onTap: () {
        Route route = MaterialPageRoute(builder: (context) => ProfilePage());
        Navigator.push(context, route); //vai al profilo
      },
    );
  }
}