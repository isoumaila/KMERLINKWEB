import 'package:flutter/material.dart';
//import 'package:dynamicsnews/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Pas de compte? " : "Avez vous déjà un compte? ",
          style: TextStyle(color: Colors.blue),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "S'inscrire" : "S'identifier",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
