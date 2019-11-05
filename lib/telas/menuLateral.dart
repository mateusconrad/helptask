import 'package:app_vai/home.dart';
import 'package:app_vai/login.dart';
import 'package:app_vai/telas/abrir_chamado.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MenuLateral extends StatefulWidget {

  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
//  final FirebaseAuth auth = FirebaseAuth.instance;
//  FirebaseUser user ;


  @override
  Widget build(BuildContext context) {
    Future<FirebaseUser> future = FirebaseAuth.instance.currentUser();
    return Drawer(
      child: ListView(
        children: <Widget>[

          UserAccountsDrawerHeader(
            accountName: Text("NOME AQUI POR FAVOVR"),
            accountEmail: Text("LEMBRADECOLOCAR@EMAIL.COM"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/yoda.jpg"),
            ),
          ),
          //SizedBox(height:100,),

          _listTile(context, Icons.help, "Ajuda", "mais informações...", _onPressed()),
          _divisor(),
//          _listTile(context, Icons.graphic_eq, "Estatísticas", "Graficos de uso"),
//          _divisor(),
//          _listTile(context, Icons.power_settings_new, "Sair", "Fazer Logout"),
          _divisor(),
        ],
      ),
    );
  }

  Divider _divisor() => Divider();

  ListTile _listTile(BuildContext context, IconData iconField, String title, String subTitle, _onPressed/*Parãmetro do onTap()=> aqui*/      ) {
    return ListTile(
        leading: Icon(iconField),
        title: Text(title),
        subtitle: Text(subTitle),
        onTap: () => _onPressed//userDetails: details
        );

//        ajuda,
//    );
  }

  VoidCallback _onPressed(){
    Navigator.push(
        context,
         MaterialPageRoute(
            builder: (context) => Login()));

    return null;
  }

  }