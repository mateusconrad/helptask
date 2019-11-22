import 'package:app_vai/drawer/TilesTelas/ajuda.dart';
import 'package:app_vai/drawer/TilesTelas/graficos.dart';
import 'package:app_vai/Login/loginUsuario.dart';
import 'package:app_vai/drawer/TilesTelas/registrarUsuario.dart';
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
    // ignore: unused_local_variable
    Future<FirebaseUser> future = FirebaseAuth.instance.currentUser();
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("${user?.displayName}"),
            accountEmail: Text("${user?.email}"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("${user?.photoUrl}", scale: 1.0),
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
//          if (EmailAuthProvider == GoogleAuthProvider)
            _listTileRegistrarUsuario(context, Icons.person_outline,
                "Novo usuário", "Registrar usuario"),
        ],
      ),
    );
  }
}

//  Divider _divisor() => Divider();
Divider _divisor() => Divider();

ListTile _listTileHelp(
    BuildContext context, IconData iconField, String title, String subTitle) {
  return ListTile(
    leading: Icon(iconField),
    title: Text(title),
    subtitle: Text(subTitle),
    onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => AjudaPage())),
  );
}

ListTile _listTileGraphics(
    BuildContext context, IconData iconField, String title, String subTitle) {
  return ListTile(
      leading: Icon(iconField),
      title: Text(title),
      subtitle: Text(subTitle),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GraficosPage()));
      });
}

ListTile _listTileLogout(
    BuildContext context, IconData iconField, String title, String subTitle) {
  return ListTile(
      leading: Icon(iconField),
      title: Text(title),
      subtitle: Text(subTitle),
      onTap: () {
        FirebaseAuth.instance.signOut();
        GoogleSignIn.standard().signOut();
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => (LoginUsuario())));
      });
}

ListTile _listTileRegistrarUsuario(
    BuildContext context, IconData iconField, String title, String subTitle) {
  return ListTile(
      leading: Icon(iconField),
      title: Text(title),
      subtitle: Text(subTitle),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => (RegistrarAtendente())));
      });
}
