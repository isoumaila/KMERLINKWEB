// ignore: import_of_legacy_library_into_null_safe
import 'package:get_it/get_it.dart';
import 'package:kmerlinkweb/Models/album.dart';
import 'package:kmerlinkweb/services/storage_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton<StorageService>(() => StorageService());
  // Register services
  locator.registerFactory<Album>(() => Album.empty());
  // Register models
}
