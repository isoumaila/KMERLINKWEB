import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kmerlinkweb/Models/album.dart';
import 'package:kmerlinkweb/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:kmerlinkweb/components/already_have_an_account_acheck.dart';
import 'package:kmerlinkweb/components/rounded_button.dart';
import 'package:kmerlinkweb/components/rounded_input_field.dart';
import 'package:kmerlinkweb/components/rounded_password_field.dart';
import 'package:kmerlinkweb/screens/Login/components/background.dart';
import 'package:kmerlinkweb/screens/ParticuliersList/particuliersList_screen.dart';
import 'package:kmerlinkweb/screens/Signup/signup_screen.dart';

const String baseURL =
    'http://ec2-3-13-144-136.us-east-2.compute.amazonaws.com:8085/kmerlink/auth';

// ignore: slash_for_doc_comments
/**
 * transformé la classe en state full : important !!!
 */
class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late User user;

  List<Album> particuliersList() {
    return [];
  }

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  _initUser() {
    user = User();
    user.telephone = 55;
  }

  Future<Album?> connexionParticulier(User user) async {
    final response = await http.post(
      Uri.parse(baseURL + '/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "login": user.email,
        "password": user.mdp,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return null; //Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //throw Exception('Failed to create particulier.');
      dynamic json = jsonDecode(response.body);
      print(json['errors']);
      print((jsonDecode(response.body)));
      print((jsonDecode(response.body)));
      print((jsonDecode(response.body)));
      return null; //Album.fromJson(jsonDecode(response.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Connexion",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "identifiant",
              onChanged: (value) {
                user.email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                user.mdp = value;
              },
            ),
            RoundedButton(
              text: "connecter",
              press: () {
                connexionParticulier(user);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ParticuliersListScreen(
                        user: user,
                        album: new Album(nom: "", id: 0, prenom: ""),
                        particuliersList: particuliersList(),
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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
