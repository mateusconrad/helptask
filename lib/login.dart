import 'package:app_vai/userDetails/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String title = "login";
  TextStyle style = TextStyle(fontSize: 20.0);

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _signIn() async {

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    FirebaseUser userDetails = (await _auth.signInWithCredential(credential));
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
    print("signed in " + userDetails.displayName);
    print("signed in " + userDetails.email);
    print("signed in " + userDetails.photoUrl);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );

    final user = UserDetails;
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(

        builder: (context) => new TabBarHome( ),//userDetails: details
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
              tituloApp(),
              _sBox(),
              botaoLogin()
            ],
          ),
        ),
      ),
    ));
  }

  Text tituloApp() {
    return Text("Help Task",
              style: TextStyle(
                fontSize: 24,
              ),
            );
  }

  GoogleSignInButton botaoLogin() {
    return GoogleSignInButton(
              onPressed: () => _signIn()
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


