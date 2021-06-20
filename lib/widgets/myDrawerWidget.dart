import 'package:flutter/material.dart';
import 'package:formulario/faqPage.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/widgets/preferitiWidget.dart';
import 'package:formulario/widgets/profileDrawerWidget.dart';
import 'package:formulario/widgets/recentiWidget.dart';

class MyDrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyDrawerWidgetState();
  }
}

//Il nostro drawer si divide in ProfilePage, Recenti, Preferiti e le FAQ
class _MyDrawerWidgetState extends State<MyDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset('assets/icons/insegnante.png'),
            )
          ],
          title: Text(
            'Formulario',
            style: TextStyle(
              fontFamily: 'Brandon-Grotesque-black',
              fontStyle: FontStyle.normal,
              fontSize: 26,
            ),
          ),
        ),
        body: ListView(
          shrinkWrap: false,
          children: [
            ProfileDrawerWidget(),
            FaqWidget(),
            PreferitiWidget(),
            RecentiWidget(),
          ],
        ),
      ),
    );
  }
}

class FaqWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.live_help_outlined,
        color: MyAppColors.iconColor,
      ),
      title: Text(
        'Faq',
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewPage1())); //vai al profilo
      },
    );
  }
}
