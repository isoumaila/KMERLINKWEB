import 'package:flutter/material.dart';
import 'package:kmerlinkweb/Models/album.dart';
import 'package:kmerlinkweb/Models/user.dart';
import 'package:kmerlinkweb/screens/InscriptionOk/components/body.dart';

class Confirmscreen extends StatelessWidget {
  const Confirmscreen({Key? key, required this.user, required this.album})
      : super(key: key);

  final User user;
  final Album album;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        user: user,
        album: album,
      ),
    );
  }
}
