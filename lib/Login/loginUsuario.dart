import 'package:app_vai/drawer/userDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUsuario extends StatefulWidget {
  @override
  _LoginUsuarioState createState() => _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {
  final String title = "login";
  TextStyle style = TextStyle(fontSize: 20.0);

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var focusUsuarioUsuario = new FocusNode();
  var focusSenhaUsuario = new FocusNode();

  TextEditingController usuarioUsuario = TextEditingController();
  TextEditingController senhaUsuario = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<FirebaseUser> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails = (await _auth.signInWithCredential(credential));
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
    print("Nome " + userDetails.displayName + "\n");
    print("Email " + userDetails.email + "\n");
    print("Photo URL" + userDetails.photoUrl + "\n");

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    // ignore: unused_local_variable
    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );

    // ignore: unused_local_variable
    final user = UserDetails;
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => new TabBarHome(), //userDetails: details
      ),
    );
    return userDetails;
  }

  IconData iconField;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _sBox(),
              _logoAbase(),
              SizedBox(
                height: 10,
              ),
              tituloApp(),
              SizedBox(
                height: 10,
              ),
              _loginField(),
              SizedBox(
                height: 10,
              ),
              _passwordField(),
              loginUsuario(context),
              botaoLoginGoogle(),
            ],
          ),
        ),
      ),
    ));
  }

  Text tituloApp() {
    return Text(
      "Help Task",
      style: TextStyle(
        fontSize: 24,
      ),
    );
  }

  TextFormField _loginField() => TextFormField(
        obscureText: false,
        style: style,
        controller: usuarioUsuario,
        textInputAction: TextInputAction.next,
        validator: (valor) {
          if (valor.isEmpty) {
            FocusScope.of(context).requestFocus(focusUsuarioUsuario);
            return "Informe a senha";
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      );

  TextFormField _passwordField() => TextFormField(
        obscureText: true,
        style: style,
        controller: senhaUsuario,
        validator: (valor) {
          if (valor.isEmpty) {
            FocusScope.of(context).requestFocus(focusSenhaUsuario);
            return "Informe a senha";
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "senha",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      );

  MaterialButton loginUsuario(BuildContext context) {
    return MaterialButton(
      elevation: 5.0,
      child: Text("Login"),
      color: Color(0xff01A0C7),
      minWidth: MediaQuery.of(context).size.width - 182,
      onPressed: () {
        if (formkey.currentState.validate()) {

          Firestore.instance
              .collection("usuarios")
              .where("login", isEqualTo: usuarioUsuario.text)
              .where("senha", isEqualTo: senhaUsuario.text)
              .getDocuments()
              .then((QuerySnapshot doc) {
            if (doc.documents.length != 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TabBarHome()));
            }
          });
        }
      },
    );
  }

  GoogleSignInButton botaoLoginGoogle() {
    return GoogleSignInButton(
      onPressed: () => _signInWithGoogle()
          .then((FirebaseUser user) => print(user))
          .catchError((e) => print(e)),
    );
  }

  SizedBox _sBox() => SizedBox(height: 100);

  ClipRRect _logoAbase() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset(
          "images/abase.jpg",
          height: 200,
        ));
  }
}
