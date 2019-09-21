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
                  TextFormField(
                    autovalidate: true,

                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    obscureText: true ,
                  ),
                  SizedBox(height: 45.0),

                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.indigoAccent,
                    child: MaterialButton(

                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => TabBarHome()));
                      },
                        child: Text("Login")
                    ),
                  ),
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
