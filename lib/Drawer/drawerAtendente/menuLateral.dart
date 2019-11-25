import 'package:app_vai/Drawer/TilesTelas/ajuda.dart';
import 'package:app_vai/Drawer/TilesTelas/graficos.dart';
import 'package:app_vai/Drawer/TilesTelas/registrarUsuario.dart';
import 'package:app_vai/Login/loginUsuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MenuLateralAtendente extends StatefulWidget {
  @override
  _MenuLateralAtendenteState createState() => _MenuLateralAtendenteState();
}

class _MenuLateralAtendenteState extends State<MenuLateralAtendente> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  Divider _divisor() => Divider(color: Colors.white10,height: 30,thickness: 2,);

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
            accountName: Text("Atendente"),
            accountEmail: Text("${user?.email}"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/abase.jpg"),
            ),
          ),
          _listTileHelp(context, Icons.help, "Ajuda", "mais informações..."),
          _divisor(),
          _listTileGraphics(
              context, Icons.graphic_eq, "Estatísticas", "Graficos de uso"),
          _divisor(),
          _listTileLogout(
              context, Icons.power_settings_new, "Sair", "Fazer Logout"),
          _divisor(),
          if (FirebaseAuth != EmailAuthProvider)
            _listTileRegistrarUsuario(context, Icons.person_outline,
              "Novo usuário", "Registrar usuario"),
        ],
      ),
    );
  }
}

//  Divider _divisor() => Divider();

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
