import 'package:flutter/material.dart';

import '../home.dart';

class BlueButton extends StatelessWidget {

  String buttonText;

  Function onPressed;


  BlueButton(this.buttonText, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      //color: Color(0xff01A0C7),
      color: Colors.indigoAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: onPressed,
//        onPressed: () {
//          Navigator.push(
//              context, MaterialPageRoute(builder: (context) => TabBarDemo()));
//        },
        child: Text(buttonText)
      ),
    );
  }

}
