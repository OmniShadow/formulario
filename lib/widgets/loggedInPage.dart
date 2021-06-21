import 'package:flutter/material.dart';
import 'package:formulario/auth.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/widgets/numbersWidget.dart';

class LoggedInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Auth.instance!.currentUser!;
    return Scaffold(
      backgroundColor: MyAppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xFF332F2D),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await Auth.instance!.signOut();
            },
            child: Text('Logout'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              'Profilo',
              style: TextStyle(
                  backgroundColor: MyAppColors.appBackground,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 32,
              bottom: 8,
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
          ),
          Text(
            user.displayName!,
            style: TextStyle(
                backgroundColor: MyAppColors.appBackground,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 22),
            textAlign: TextAlign.center,
          ),
          Text(
            user.email!,
            style: TextStyle(
                backgroundColor: MyAppColors.appBackground,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 22),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48, bottom: 48),
            child: NumbersWidget(),
          ),
          // Text(
          //   "Formule da vedere:\n",
          //   style: TextStyle(
          //       backgroundColor: MyAppColors.appBackground,
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 22),
          //   textAlign: TextAlign.center,
          // ),
          // Text(
          //   Assets.instance.userData.cosaFare.isEmpty
          //       ? "Cosa vuoi vedere oggi?"
          //       : Assets.instance.userData.cosaFare,
          //   style: TextStyle(
          //       backgroundColor: MyAppColors.appBackground,
          //       color: Colors.grey[800],
          //       fontWeight: FontWeight.bold,
          //       fontSize: 22),
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}
