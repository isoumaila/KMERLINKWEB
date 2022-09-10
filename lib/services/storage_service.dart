import 'dart:convert';

import 'package:kmerlinkweb/Models/album.dart';
import 'package:kmerlinkweb/Models/user.dart';
import 'package:http/http.dart' as http;

class StorageService {
  final String baseURL =
      'http://ec2-3-13-144-136.us-east-2.compute.amazonaws.com:8085/kmerlink/particuliers';
  Future<bool> saveData() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
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
}
