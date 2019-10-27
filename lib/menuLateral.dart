//import 'package:app_vai/login.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Master Yoda"),
            accountEmail: Text("yoda@sw.uni.verse"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/yoda.jpg"),
            ),
          ),
          //SizedBox(height:100,),

          _ListTile(context, Icons.help, "Ajuda", "mais informações...", Icons.live_help),
          _ListTile(context, Icons.transit_enterexit, "Sair", "Fazer Logout", Icons.power_settings_new),

        ],
      ),
    );
  }

  ListTile _ListTile(BuildContext context, IconData iconField, String title, String subTitle, IconData iconTrail) {
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
