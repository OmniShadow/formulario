//Una volta cliccato sul nostro profilo apparirà il nome utente, email e le cose da fare, ovvero tutto ciò
//che viene inserito dall'utente nel proprio profilo
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formulario/auth.dart';
import 'package:formulario/widgets/loginPageScreen.dart';
import 'package:formulario/constantsUtil.dart';
import 'package:formulario/widgets/numbersWidget.dart';

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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return LoggedInPage();
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Qualcosa `e andato storto',
            ),
          );
        }
        return SignUpPageScreen();
        // return ListView(
        //   physics: BouncingScrollPhysics(),
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(top: 24),
        //       child: Text(
        //         Assets.instance.userData.username.isEmpty
        //             ? "Nome Utente"
        //             : Assets.instance.userData.username,
        //         style: TextStyle(
        //             backgroundColor: MyAppColors.appBackground,
        //             color: Colors.grey[800],
        //             fontWeight: FontWeight.bold,
        //             fontSize: 22),
        //         textAlign: TextAlign.center,
        //       ),
        //     ),
        //     Text("\n"),
        //     Text(
        //       Assets.instance.userData.email.isEmpty
        //           ? "E-mail"
        //           : Assets.instance.userData.email,
        //       style: TextStyle(
        //           backgroundColor: MyAppColors.appBackground,
        //           color: Colors.grey[800],
        //           fontWeight: FontWeight.bold,
        //           fontSize: 22),
        //       textAlign: TextAlign.center,
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 48, bottom: 48),
        //       child: NumbersWidget(),
        //     ),
        //     Text(
        //       "Formule da vedere:\n",
        //       style: TextStyle(
        //           backgroundColor: MyAppColors.appBackground,
        //           color: Colors.black,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 22),
        //       textAlign: TextAlign.center,
        //     ),
        //     Text(
        //       Assets.instance.userData.cosaFare.isEmpty
        //           ? "Cosa vuoi vedere oggi?"
        //           : Assets.instance.userData.cosaFare,
        //       style: TextStyle(
        //           backgroundColor: MyAppColors.appBackground,
        //           color: Colors.grey[800],
        //           fontWeight: FontWeight.bold,
        //           fontSize: 22),
        //       textAlign: TextAlign.center,
        //     ),
        //   ],
        // );
      },
    );
  }
}

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
            onPressed: () {},
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
