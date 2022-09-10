import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kmerlinkweb/Models/album.dart';
import 'package:kmerlinkweb/Models/user.dart';
import 'package:kmerlinkweb/screens/ParticuliersList/components/body.dart';
import 'package:kmerlinkweb/wrappers/stateful_wrapper.dart';
import 'package:http/http.dart' as http;

class ParticuliersListScreen extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ParticuliersListScreen(
      {Key? key,
      required this.user,
      required this.album,
      required this.particuliersList})
      : super(key: key);

  final User user;
  final Album album;
  late List<Album> particuliersList;

  final String baseURL =
      'http://ec2-3-13-144-136.us-east-2.compute.amazonaws.com:8085/kmerlink/particuliers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        user: user,
        album: album,
        particuliersList: particuliersList,
      ),
    );
  }
}
