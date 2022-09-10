import 'package:flutter/material.dart';
import 'package:kmerlinkweb/constants.dart';
import 'package:kmerlinkweb/screens/Welcome/welcome_screen.dart';
import 'package:kmerlinkweb/services/service_locator.dart';

void main() {
  setupLocator();
  runApp(KmerlinkApp());
}

class KmerlinkApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kmerlink App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
