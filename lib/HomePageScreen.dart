import 'package:flutter/material.dart';
import 'package:formulario/Assets.dart';
import 'constantsUtil.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomePageScreenState createState() => HomePageScreenState();
}

class HomePageScreenState extends State<HomePageScreen> {
  static String username = UserData.DEFAULT_USERNAME;
  static String email = UserData.DEFAULT_EMAIL;
  static String cosaFare = UserData.DEFAULT_COSAFARE;
  var controller1 = TextEditingController(text: username);
  var controller2 = TextEditingController(text: email);
  var controller3 = TextEditingController(text: cosaFare);

  /*
  TextEditingController text1Ctrl = TextEditingController();
  TextEditingController text2Ctrl = TextEditingController();
  */
  void _showMessage(BuildContext context, String msg) {
    print(context);

    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  /*
  @override
  void dispose() {
    text1Ctrl.dispose();
    text2Ctrl.dispose();
    super.dispose();
  }
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.appBackground,
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                'Dammi il tuo nome, la tua email e ciò che vuoi fare oggi:',
                textAlign: TextAlign.center,
                style: TextStyle(
                    backgroundColor: MyAppColors.appBackground,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              TextField(
                controller: controller1,
                onTap: () => controller1.text = '',
                onChanged: (text) {
                  username = text;
                },
              ),
              TextField(
                controller: controller2,
                onTap: () => controller2.text = '',
                onChanged: (text) {
                  email = text;
                },
              ),
              TextField(
                controller: controller3,
                onTap: () => controller3.text = '',
                onChanged: (text) {
                  cosaFare = text;
                },
              ),
              MaterialButton(
                onPressed: () {
                  Assets.instance.updateUsername(username, email, cosaFare);
                  setState(() {});
                },
                child: Text('Invia'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
