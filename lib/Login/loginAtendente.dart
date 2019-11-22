import 'package:app_vai/homeAtendente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginAtendente extends StatefulWidget {
  @override
  _LoginAtendenteState createState() => _LoginAtendenteState();
}

class _LoginAtendenteState extends State<LoginAtendente> {
  TextEditingController nomeUsuario = TextEditingController();
  TextEditingController senhaUsuario = TextEditingController();

  var focusNomeUsuario = new FocusNode();
  var focusSenhaUsuario = new FocusNode();
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  initState() {
    _loginFormKey = GlobalKey<FormState>();
    nomeUsuario = TextEditingController();
    senhaUsuario = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginFormKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 150, right: 10),
          child: Column(
            children: <Widget>[
              Text("Acesso Atendente",),
              fieldUser(context),
              fieldSenha(context),
              RaisedButton(
                  onPressed: (){
                    if (_loginFormKey.currentState.validate()) {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: nomeUsuario.text,
                          password: senhaUsuario.text)
                          .then((currentUser) => Firestore.instance
                          .collection("users")
                          .document(currentUser.uid)
                          .get()
                          .then((DocumentSnapshot result) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabBarHome())))
                          .catchError((err) => print(err)))
                          .catchError((err) => print(err));
                    }
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField fieldSenha(BuildContext context) {
    return TextFormField(
      focusNode: focusSenhaUsuario,
      obscureText: true,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(labelText: "Senha", icon: Icon(Icons.lock)),
      keyboardType: TextInputType.visiblePassword,
      controller: senhaUsuario,
      validator: (valor) {
        if (valor.isEmpty) {
          FocusScope.of(context).requestFocus(focusSenhaUsuario);
          return "Informe a senha";
        }
        return null;
      },
    );
  }

  TextFormField fieldUser(BuildContext context) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Usuário", icon: Icon(Icons.people)),
      keyboardType: TextInputType.emailAddress,
      controller: nomeUsuario,
      autofocus: true,
      validator: (valor) {
        if (valor.isEmpty) {
          FocusScope.of(context).requestFocus(focusNomeUsuario);
          return "Informe o nome";
        }
        return null;
      },
    );
  }
}
