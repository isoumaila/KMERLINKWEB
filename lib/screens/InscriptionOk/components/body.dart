import 'package:flutter/material.dart';
import 'package:kmerlinkweb/Models/album.dart';
import 'package:kmerlinkweb/Models/user.dart';
import 'package:kmerlinkweb/components/rounded_button.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:kmerlinkweb/screens/Login/components/background.dart';
import 'package:kmerlinkweb/screens/Login/login_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.user, required this.album})
      : super(key: key);

  final User user;
  final Album album;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Merci pour votre inscription !!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Aller à la page de connexion: " +
                  user.nom +
                  " " +
                  user.prenom,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "HTTP RESULTAT " + album.nom + " " + album.id.toString(),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
