
import 'package:app_vai/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MenuLateral extends StatefulWidget {
  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {
      initUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<FirebaseUser> future = FirebaseAuth.instance.currentUser();
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("${user?.displayName}"),
            accountEmail: Text("${user?.email}"),
            currentAccountPicture: CircleAvatar(
              backgroundImage:  NetworkImage("${user?.photoUrl}"),
            ),

          ),
          //SizedBox(height:100,),

          _listTileHelp(context, Icons.help, "Ajuda", "mais informações..."),
          _divisor(),
          _listTileGraphics(
              context, Icons.graphic_eq, "Estatísticas", "Graficos de uso"),
          _divisor(),
          _listTileLogout(
              context, Icons.power_settings_new, "Sair", "Fazer Logout"),
          _divisor(),
          ListTile(),

        ],
      ),
    );
  }

  Divider _divisor() => Divider();
}

//  Divider _divisor() => Divider();

ListTile _listTileHelp(BuildContext context, IconData iconField, String title, String subTitle ) {
  return ListTile(
    leading: Icon(iconField),
    title: Text(title),
    subtitle: Text(subTitle),
    onTap: () => null,
  );
}

ListTile _listTileGraphics(BuildContext context, IconData iconField,String title, String subTitle) {
  return ListTile(
    leading: Icon(iconField),
    title: Text(title),
    subtitle: Text(subTitle),
    onTap: () => null,
  );
}

ListTile _listTileLogout(BuildContext context, IconData iconField, String title, String subTitle ) {
  return ListTile(
    leading: Icon(iconField),
    title: Text(title),
    subtitle: Text(subTitle),
    onTap: () {
      FirebaseAuth.instance.signOut();
      GoogleSignIn.channel.invokeMethod("signOut");
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => (Login())));
    }
  );
}


