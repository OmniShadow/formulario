import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formulario/assets.dart';
import 'package:formulario/auth.dart';
import 'package:formulario/googleSignInProvider.dart';
import 'package:provider/provider.dart';
import '../constantsUtil.dart';

class SignUpPageScreen extends StatefulWidget {
  @override
  _SignUpPageScreenState createState() => _SignUpPageScreenState();
}

class _SignUpPageScreenState extends State<SignUpPageScreen> {
  static String username = UserData.DEFAULT_USERNAME;
  static String email = UserData.DEFAULT_EMAIL;
  static String cosaFare = UserData.DEFAULT_COSAFARE;
  var controller1 = TextEditingController(text: username);
  var controller2 = TextEditingController(text: email);
  var controller3 = TextEditingController(text: cosaFare);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.appBackground,
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(
              width: 120,
              height: 120,
              child: Image.asset(MyAppConstants.appIconPath),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ciao,\nBentornato!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8,
              ),
              child: Text(
                'Fai il login con il tuo account per continuare',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () async {
                // final provider =
                //     Provider.of<GoogleSignInProvider>(context, listen: false);
                // provider.googleLogin();
                await Auth.instance!.signInWithGoogle();
              },
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: MyAppColors.shirtColor,
              ),
              label: Text('Sign Up with Google'),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () async {
                // final provider =
                //     Provider.of<GoogleSignInProvider>(context, listen: false);
                // provider.googleLogin();
                var user = await Auth.instance!.signInAnonymously();
                print(user);
              },
              icon: FaIcon(
                Icons.account_circle_rounded,
                color: Colors.grey,
              ),
              label: Text('Sign Up Anonumously'),
            ),
            Spacer(),
          ],
        ),
      ),
      // body: Builder(builder: (context) {
      //   return Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Column(
      //       children: <Widget>[
      //         Text(
      //           'Dammi il tuo nome, la tua email e ciò che vuoi fare oggi:',
      //           textAlign: TextAlign.center,
      //           style: TextStyle(
      //               backgroundColor: MyAppColors.appBackground,
      //               color: Colors.grey[800],
      //               fontWeight: FontWeight.bold,
      //               fontSize: 22),
      //         ),
      //         TextField(
      //           controller: controller1,
      //           onTap: () => controller1.text = '',
      //           onChanged: (text) {
      //             username = text;
      //           },
      //         ),
      //         TextField(
      //           controller: controller2,
      //           onTap: () => controller2.text = '',
      //           onChanged: (text) {
      //             email = text;
      //           },
      //         ),
      //         TextField(
      //           controller: controller3,
      //           onTap: () => controller3.text = '',
      //           onChanged: (text) {
      //             cosaFare = text;
      //           },
      //         ),
      //         MaterialButton(
      //           onPressed: () {
      //             Assets.instance.updateUsername(username, email, cosaFare);
      //             setState(() {});
      //           },
      //           child: Text('Invia'),
      //         ),
      //       ],
      //     ),
      //   );
      // }),
    );
  }
}
