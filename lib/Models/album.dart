import 'package:kmerlinkweb/Models/base_model.dart';
import 'package:kmerlinkweb/Models/user.dart';
import 'package:kmerlinkweb/services/service_locator.dart';
import 'package:kmerlinkweb/services/storage_service.dart';
import 'package:scoped_model/scoped_model.dart';

class Album extends BaseModel {
  late String nom;
  late int id;
  late String prenom;

  List<Album> particuliersList = [];

  StorageService storageService = locator<StorageService>();

  Album({
    required this.nom,
    required this.id,
    required this.prenom,
  });

  Future fetchList(List<Album> list) async {
    setState([]);
    await Future.delayed(Duration(seconds: 2));
    particuliersList = list;

    setState([]);
  }

  Future saveParticulier(User user) async {
    await storageService.createParticulierStatic(user);
  }

  Future<List<Album>> fetchAllParticuliersList() async {
    return await storageService.fetchAllParticuliersList();
  }

  Album.non(this.nom, this.id, this.prenom) {
    this.nom = nom;
    this.id = id;
    this.prenom = prenom;
  }

  factory Album.fromJson(dynamic json) {
    return Album(
      nom: json['nom'],
      id: json['id'],
      prenom: json['prenom'],
    );
  }

  Album.fromRaw(Map<String, dynamic> map) // Constructor
      : nom = map['nom'],
        id = map['id'],
        prenom = map['prenom'];

  fromRaw(Map<String, dynamic> empRaw) {
    return Album(
      nom: empRaw['nom'],
      id: empRaw['id'],
      prenom: empRaw['prenom'],
    );
  }

  Album.empty() {
    nom = "";
    id = 0;
    prenom = "";
  }

  @override
  String toString() {
    return "Particulier: [nom=${this.nom},id=${this.id},prenom=${this.prenom}]";
  }
}
