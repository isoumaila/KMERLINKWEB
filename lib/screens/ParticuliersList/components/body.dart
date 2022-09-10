import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kmerlinkweb/Models/album.dart';
import 'package:kmerlinkweb/Models/user.dart';
import 'package:kmerlinkweb/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:kmerlinkweb/screens/ParticuliersList/components/background.dart';
import 'package:kmerlinkweb/screens/Login/login_screen.dart';
import 'package:kmerlinkweb/wrappers/base_view.dart';
import 'package:kmerlinkweb/wrappers/stateful_wrapper.dart';

class Body extends StatelessWidget {
  Body(
      {Key? key,
      required this.user,
      required this.album,
      required this.particuliersList})
      : super(key: key);

  final User user;
  final Album album;
  late final List<Album> particuliersList;
  final String baseURL =
      'http://ec2-3-13-144-136.us-east-2.compute.amazonaws.com:8085/kmerlink/particuliers';

  @override
  Widget build(BuildContext context) {
    return BaseView<Album>(
      onModelReady: (model) {
        model.saveParticulier(user);
        model
            .fetchAllParticuliersList()
            .then((value) => model.fetchList(value));
      },
      builder: (context, child, model) => Background(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: getTextWidgetsList(model.particuliersList, user),
        ),
      ),
    );
  }
  /* @override
  Widget build(BuildContext context) {
    return Background(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: getTextWidgetsList(particuliersList, user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: (particuliersList) async {
        print('Initialisation de ParticuliersListScreen');

        particuliersList = await getUserRole(user).then((value) => () {
              particuliersList = value;
              return value;
            });
      },
      child: Background(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: getTextWidgetsList(particuliersList, user),
        ),
      ),
    );
  }
*/

// ignore: slash_for_doc_comments
/**ListView(
            padding: const EdgeInsets.all(8),
            children: getTextWidgetsList(particuliersList, user),
          ),
 * Creation d'une liste de WWidgets de ype text
 */
  List<Widget> getTextWidgetsList(List<Album> particuliersList1, User user) {
    List<Widget> list = <Widget>[];
    //Ajout des particuliers dans la vue de la Widget
    ajoutDesparticuliersDansVueListWidget(particuliersList1, list, user);
    //Ajout des particuliers dans la vue de la Widget
    addParticuliersListToTheView(list, particuliersList1);
    return list;
  }

  void ajoutDesparticuliersDansVueListWidget(
      List<Album> particuliersList1, List<Widget> list, User user) {
    if (particuliersList1.isNotEmpty) {
      list.add(Text(
        "nom: " +
            user.nom +
            " prenom: " +
            user.prenom +
            " dn: " +
            user.dateDeNaissance.toString() +
            " tel: " +
            user.telephone.toString() +
            " em: " +
            user.email,
        style: const TextStyle(
          fontSize: 30.0,
          color: Colors.green,
          fontWeight: FontWeight.bold,
          // ignore: prefer_const_literals_to_create_immutables
          shadows: [
            Shadow(
              blurRadius: 10.0,
              color: Colors.blue,
              offset: Offset(5.0, 5.0),
            ),
            Shadow(
              color: Colors.red,
              blurRadius: 10.0,
              offset: Offset(-5.0, 5.0),
            ),
          ],
          decoration: TextDecoration.underline,
          decorationColor: Colors.black,
          decorationStyle: TextDecorationStyle.solid,
          letterSpacing: -1.0,
          wordSpacing: 5.0,
          fontFamily: 'YourCustomFont',
        ),
      ));
    }
  }

// ignore: slash_for_doc_comments
/**
 * Ajout des particuliers dans la vue de la Widget
 */
  void addParticuliersListToTheView(
      List<Widget> list, List<Album> particuliersList1) {
    for (var i = 0; i < particuliersList1.length; i++) {
      // ignore: unnecessary_new
      list.add(new Text(
        particuliersList1[i].nom,
        style: const TextStyle(
          fontSize: 30.0,
          color: Colors.tealAccent,
          fontWeight: FontWeight.bold,
          // ignore: prefer_const_literals_to_create_immutables
          shadows: [
            Shadow(
              blurRadius: 10.0,
              color: Colors.blue,
              offset: Offset(5.0, 5.0),
            ),
            Shadow(
              color: Colors.red,
              blurRadius: 10.0,
              offset: Offset(-5.0, 5.0),
            ),
          ],
          decoration: TextDecoration.underline,
          decorationColor: Colors.black,
          decorationStyle: TextDecorationStyle.solid,
          letterSpacing: -1.0,
          wordSpacing: 5.0,
          fontFamily: 'YourCustomFont',
        ),
      ));
    }
  }
/*
  Future<List<Album>> getUserRole1(User user) async {
    return await fetchAllParticuliersList().then((docs) async {
      particuliersList = await _getParticulierList(docs);
      await createParticulierStatic(user);
      return particuliersList;
    });
  }

  Future<List<Album>> getUserRole(User user) async {
    return await createParticulierStatic(user).then((user) async {
      return await fetchAllParticuliersList().then((docs) {
        // ignore: prefer_typing_uninitialized_variables

        particuliersList = _getParticulierList(docs);
        return particuliersList;
      });
    });
  }*/

  Future<List<Album>> fetchAllParticuliersList() async {
    //await createParticulierStatic(user);
    final response = await http.get(Uri.parse(baseURL + '/all'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> json = jsonDecode(response.body);
      print('appel de la liste: fetchAllParticuliersList()');
      return _decodeDynamicListToObject(json);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('Failed to load album : fetchAllParticuliersList()');
      throw Exception('Failed to load album');
    }
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

// ignore: slash_for_doc_comments
/**
 *  "nom": "SIMO KAMGA",
  "prenom": "Romeo",
  "dateDeNaissance": "1985-03-15",
  "email": "romeosimo@outlook.com",
  "motDePasse": "12345678Ro",
  "telephone": "+2376452166975",
  "question": "QUESTION_COMPTE_BANCAIRE",
  "reponse": 2975,
  "localisation": {
 */
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
      print('ParticuliersListScreen : Inscription reussie !!');
      return Album.fromJson(jsonDecode(response.body));
    } else {
      print('ParticuliersListScreen : Inscription non reussie !!');
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //throw Exception('Failed to create particulier.');
      dynamic json = jsonDecode(response.body);
      print(json['errors']);
      print((jsonDecode(response.body)));
      return Album.fromJson(jsonDecode(response.body));
    }
  }
}
