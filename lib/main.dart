import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MaterialApp(
  home : Auth(),
));

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Auth Amigo Testing"),
        backgroundColor: Colors.green[400],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FlatButton(
                onPressed: (){}, 
                child: Text("Email/Password"),
                splashColor: Colors.green,
                color: Colors.green[600],
                textColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FlatButton(
                onPressed: (){
                  _handleSignIn()
                  .then((FirebaseUser user) => print(user))
                  .catchError((e) => print(e));
                  print("aktif");
                }, 
                child: Text("Google"),
                splashColor: Colors.red,
                color: Colors.red[900],
                textColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FlatButton(
                onPressed: (){}, 
                child: Text("Facbook"),
                splashColor: Colors.blue,
                color: Colors.blue[900],
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}