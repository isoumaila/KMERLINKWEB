import 'package:kmerlinkweb/Models/album.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model {
  late List<Album> _particuliersLis;
  List<Album> get state => _particuliersLis;

  void setState(List<Album> particuliersLis) {
    _particuliersLis = particuliersLis;
    notifyListeners();
  }
}
