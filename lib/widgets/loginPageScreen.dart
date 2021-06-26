import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formulario/auth.dart';
import '../constantsUtil.dart';

class SignUpPageScreen extends StatefulWidget {
  @override
  _SignUpPageScreenState createState() => _SignUpPageScreenState();
}

class _SignUpPageScreenState extends State<SignUpPageScreen> {
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
                await Auth.instance!.signInWithGoogle();
              },
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: MyAppColors.shirtColor,
              ),
              label: Text('Sign Up with Google'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
