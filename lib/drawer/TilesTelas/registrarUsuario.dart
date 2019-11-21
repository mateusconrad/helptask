import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


GlobalKey<FormState> formkey = GlobalKey<FormState>();

TextEditingController nomeUsuario = TextEditingController();
TextEditingController senhaUsuario = TextEditingController();

var focusNomeUsuario = new FocusNode();
var focusSenhaUsuario = new FocusNode();

class RegistraUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: <Widget>[
          Text("registro"),
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
            decoration:
            InputDecoration(labelText: "Senha", icon: Icon(Icons.lock)),
            keyboardType: TextInputType.text,
            controller: senhaUsuario,
          ),
          RaisedButton(
              child: Text(
                "Registrar-se",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
//                if (formkey.currentState.validate()) {
                  Firestore.instance
                      .collection("usuarios")
                      .document()
                      .setData({
                    'login': nomeUsuario.text,
                    'senha': senhaUsuario.text,
                  });
//                }
              }),
        ],
      ),
    );
  }
}
