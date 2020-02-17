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
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String loginMethod;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    IdTokenResult idTokenResult = await authResult.user.getIdToken();
    print(idTokenResult.token);

    // print(googleSignInAuthentication.idToken);
    loginMethod = "Google";
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
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
                  signInWithGoogle().then((value) => print(value));
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FlatButton(
                onPressed: (){
                  signOutGoogle();
                  print("Logout");
                }, 
                child: Text("Sign out"),
                splashColor: Colors.black,
                color: Colors.black87,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}