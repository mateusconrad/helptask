import 'package:app_vai/widgets/blue_button.dart';
import 'package:flutter/material.dart';
import 'home.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String title = "login";
  TextStyle style = TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 45.0),

                  BlueButton("Login",onPressed: Navigator.push(context, MaterialPageRoute(builder:  (context) => TabBarDemo()))),
                    //onPressed: Navigator.push(context, MaterialPageRoute(builder: (context) => TabBarDemo())))
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
    ));
  }
}
//////////////////////
