// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:kmerlinkweb/Models/album.dart';
import 'package:kmerlinkweb/Models/user.dart';

import 'dart:convert';
import 'package:kmerlinkweb/components/already_have_an_account_acheck.dart';
import 'package:kmerlinkweb/components/rounded_Ninput_field.dart';
import 'package:kmerlinkweb/components/rounded_button.dart';
import 'package:kmerlinkweb/components/rounded_input_field.dart';
import 'package:kmerlinkweb/components/rounded_password_field.dart';
import 'package:kmerlinkweb/components/text_field_container.dart';
import 'package:kmerlinkweb/screens/Login/components/background.dart';
import 'package:kmerlinkweb/screens/Login/login_screen.dart';
import 'package:kmerlinkweb/screens/ParticuliersList/particuliersList_screen.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String defStr = "Rien";
  late User user;
  late Album album;
  late List<Album> particuliersList = [];
  late TextEditingController dateinput = TextEditingController();

  final String baseURL =
      'http://ec2-3-13-144-136.us-east-2.compute.amazonaws.com:8085/kmerlink/particuliers';

  Future<Album> createParticulier(User user) async {
    final response = await http.post(
      Uri.parse(baseURL + '/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "id": 0,
        "nom": user.nom,
        "prenom": user.prenom,
        "dateDeNaissance": user.dateDeNaissanceString,
        "email": user.email,
        "motDePasse": user.mdp,
        "telephone": user.telephoneString,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create particulier.');
    }
  }

  Future<Album> createParticulierStatic(User user) async {
    final response = await http.post(
      Uri.parse(baseURL + '/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "specialites": [
          {
            "id": 0,
            "libelle": "Cordonnier",
            "description": "Fabrication et reparation de mocassins"
          }
        ],
        "id": 0,
        "nom": user.nom,
        "prenom": user.prenom,
        "dateDeNaissance": user.dateDeNaissanceString,
        "email": user.email,
        "motDePasse": user.mdp,
        "telephone": "+" + user.telephoneString,
        "question": "QUESTION_COMPTE_BANCAIRE",
        "reponse": 2975,
        "localisation": {
          "id": 0,
          "region": "Ouest",
          "ville": "Baffoussam",
          "quartier": "Tougang"
        },
        "image": {"id": 0, "url": "url-image"}
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('Inscription reussie !!');
      return Album.fromJson(jsonDecode(response.body));
    } else {
      print('Inscription non reussie !!');
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //throw Exception('Failed to create particulier.');
      dynamic json = jsonDecode(response.body);
      print(json['errors']);
      print((jsonDecode(response.body)));
      return Album.fromJson(jsonDecode(response.body));
    }
  }

  Future<Album> fetchAlbum() async {
    final response = await http.get(Uri.parse(baseURL + '/all'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> json = jsonDecode(response.body);
      return _initFromConstructor(json[2]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Album>> fetchAllParticuliersList() async {
    final response = await http.get(Uri.parse(baseURL + '/all'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> json = jsonDecode(response.body);
      return _decodeDynamicListToObject(json);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    _initUser();
    _initAlbum();

    fetchAlbum().then((value) => {
          print(value.id),
          print(value.nom),
          print(value.prenom),
          album = Album(nom: value.nom, id: value.id, prenom: value.prenom),
          _logs()
        });

    /* fetchAllParticuliersList().then((value) => {
          print(value.length),
          print(value[0]),
          print(value[1]),
          print(value[2]),
          particuliersList = _getParticulierList(value)
        });*/
  }

  _initAlbum() {
    album = Album.empty();
  }

  _initUser() {
    dateinput.text = ""; //set the initial value of text field
    user = User();
    user.telephone = 55;
  }

  _initFromConstructor(dynamic child) {
    var empRaw = child as Map<String, dynamic>;
    return Album.fromRaw(empRaw);
  }

  _decodeDynamicListToObject(List<dynamic> children) {
    List<Album> listPar = [];
    for (dynamic child in children) {
      var childMap = child as Map<String, dynamic>;
      listPar.add(Album.fromRaw(childMap));
    }
    return listPar;
  }

  _getParticulierList(List<Album> children) {
    for (Album value in children) {
      Album album = Album(nom: value.nom, id: value.id, prenom: value.prenom);
      particuliersList.add(album);
    }

    return particuliersList;
  }

  _logs() {
    print("Nom: " + album.nom + "prenom: " + album.prenom);
    print("Le to String: " + album.toString());
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
              "Inscription",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Nom",
              onChanged: (value) {
                user.nom = value;
              },
            ),
            RoundedInputField(
              hintText: "Prenom",
              onChanged: (value) {
                user.prenom = value;
              },
            ),
            TextFieldContainer(
              child: TextField(
                controller: dateinput, //editing controller of this TextField
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    color: kPrimaryColor,
                  ), //icon of text field
                  labelText: "Date de naissance", //label text of field
                  border: InputBorder.none,
                ),

                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      user.dateDeNaissance = pickedDate;
                      dateinput.text =
                          formattedDate; //set output date to TextField value.
                      user.dateDeNaissanceString = formattedDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
            RoundedNInputField(
              hintText: "Téléphone",
              onChanged: (value) {
                int v = int.parse(value);
                user.telephone = v;
                user.telephoneString = value;

                // user.telephone = value.;
              },
            ),
            RoundedInputField(
              hintText: "Email",
              icon: Icons.email,
              onChanged: (value) {
                user.email = value;
              },
              textInputType: TextInputType.emailAddress,
            ),
            RoundedPasswordField(
              onChanged: (value) {
                user.mdp = value;
              },
            ),
            RoundedButton(
              text: 'S\'inscrire',
              press: () async {
                //l'inscription est fait après l'appel de la liste
                // createParticulierStatic(user);
                await fetchAllParticuliersList().then((value) => () {
                      particuliersList = _getParticulierList(value);
                      return particuliersList;
                    });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ParticuliersListScreen(
                        user: user,
                        album: album,
                        particuliersList: particuliersList,
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
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
            //OrDivider(),
          ],
        ),
      ),
    );
  }
}
