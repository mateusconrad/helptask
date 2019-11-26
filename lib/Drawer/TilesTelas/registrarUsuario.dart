import 'package:app_vai/Login/loginUsuario.dart';
import 'package:app_vai/homeAtendente.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrarAtendente extends StatefulWidget {
  RegistrarAtendente({Key key}) : super(key: key);

  @override
  _RegistrarAtendenteState createState() => _RegistrarAtendenteState();
}

class _RegistrarAtendenteState extends State<RegistrarAtendente> {
  final GlobalKey<FormState> _keyRegistro = GlobalKey<FormState>();
  TextEditingController nomeController;
  TextEditingController sobrenomeController;
  TextEditingController emailController;
  TextEditingController senhaController;
  TextEditingController confirmaSenhaController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registro Atendente"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _keyRegistro,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Nome*', hintText: "Samuel da Silveira"),
                        controller: nomeController,
                        validator: (value) =>
                          (value.length < 3)? "Insira um nome válido!": null,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Last Name*', hintText: "Doe"),
                          controller: sobrenomeController,
                        validator: (value) =>
                        (value.length < 3)? "Insira um sobrenome válido!": null,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email', hintText: "samisempai@bol.com"),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password*', hintText: "********"),
                        controller: senhaController,
                        obscureText: true,
                        validator: validaSenha,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Confirm Password*', hintText: "********"),
                        controller: confirmaSenhaController,
                        obscureText: true,
                        validator: validaSenha,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text("Registrar"),
                          color: Colors.blueGrey,
                          elevation: 30,
                          textColor: Colors.white,
                          onPressed: () {
                            if (_keyRegistro.currentState.validate()) {
                              if (senhaController.text ==
                                  confirmaSenhaController.text) {
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: senhaController.text)
                                    .then((currentUser) => Firestore.instance
                                    .collection("users")
                                    .document(currentUser.uid)
                                    .setData({
                                  "uid": currentUser.uid,
                                  "fname": nomeController.text,
                                  "surname": sobrenomeController.text,
                                  "email": emailController.text,
                                  "adm":1,
                                }).then((result) => {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TabBarHomeAtendente()),
                                          (_) => false),
                                  nomeController.clear(),
                                  sobrenomeController.clear(),
                                  emailController.clear(),
                                  senhaController.clear(),
                                  confirmaSenhaController.clear()
                                })
                                    .catchError((err) => print(err)))
                                    .catchError((err) => print(err));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text("The passwords do not match"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  @override
  initState() {
    nomeController = new TextEditingController();
    sobrenomeController = new TextEditingController();
    emailController = new TextEditingController();
    senhaController = new TextEditingController();
    confirmaSenhaController = new TextEditingController();
    super.initState();
  }

  // ignore: missing_return
  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    // ignore: unnecessary_statements
    !regex.hasMatch(value)? 'Email inválido!': null;
  }
  String validaSenha(String value) => (value.length < 8)? 'A senha deve conter no mínimo 8 caracteres!' : null;
}
//    if (!regex.hasMatch(value)) {
//      return 'Email inválido!';
//    } else {
//      return null;
//    }

//
//    if (value.length < 8) {
//      return 'A senha deve conter no mínimo 8 caracteres!';
//    } else {
//      return null;
//    }