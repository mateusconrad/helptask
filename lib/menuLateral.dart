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
            accountName: Text(""),
            accountEmail: Text(""),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/yoda.jpg"),
            ),
          ),
          //SizedBox(height:100,),

          _listTile(context, Icons.help, "Ajuda", "mais informações...", Icons.live_help),
          _listTile(context, Icons.transit_enterexit, "Sair", "Fazer Logout", Icons.power_settings_new),

        ],
      ),
    );
  }

  ListTile _listTile(BuildContext context, IconData iconField, String title, String subTitle, IconData iconTrail) {
    return ListTile(
          leading: Icon(iconField),
          title: Text(title),
          subtitle: Text(subTitle),
          trailing: Icon(iconTrail),
          onTap: () {
            print("Item 1");
//            Navigator.pop(context);
          },
        );
  }
}
