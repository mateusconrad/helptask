import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var focusNomeUsuario = new FocusNode();
  var focusSenhaUsuario = new FocusNode();

  TextEditingController nomeUsuario = TextEditingController();
  TextEditingController senhaUsuario = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  validator: (valor) {
                    if (valor.isEmpty) {
                      FocusScope.of(context).requestFocus(focusNomeUsuario);
                      return "Informe o nome";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Usuário", icon: Icon(Icons.people)),
                  keyboardType: TextInputType.text,
                  controller: nomeUsuario,
                ),
                TextFormField(
                  focusNode: focusSenhaUsuario,
                  autofocus: true,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      FocusScope.of(context).requestFocus(focusSenhaUsuario);
                      return "Informe a senha";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Senha", icon: Icon(Icons.lock)),
                  keyboardType: TextInputType.text,
                  controller: senhaUsuario,
                ),
                RaisedButton(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {

                RaisedButton(
                    child: Text(
                      "Registrar-se",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        Firestore.instance
                            .collection("usuarios")
                            .document()
                            .setData({
                          'login': nomeUsuario.text,
                          'senha': senhaUsuario.text,
                        });
                        //setState(() {});
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}