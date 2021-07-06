import 'package:dhvani/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthentication extends StatefulWidget {
  const FirebaseAuthentication({Key? key}) : super(key: key);

  @override
  _FirebaseAuthenticationState createState() => _FirebaseAuthenticationState();
}

class _FirebaseAuthenticationState extends State<FirebaseAuthentication> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late FirebaseAuth _auth;
  bool isUserSignedIn = false;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    // immediately check whether the user is signed in
    checkIfUserIsSignedIn();
  }
    void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });
  }

  Future<User> _handleSignIn() async {
    User user;
    bool userSignedIn = await _googleSignIn.isSignedIn();  
    
    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if (isUserSignedIn) {
      user = _auth.currentUser!;
    }
    else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user!;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    var userSignedIn = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WelcomeUserWidget(user : user, googleSignIn : _googleSignIn)),
            );

    setState(() {
      isUserSignedIn = userSignedIn == null ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Align(
          alignment: Alignment.center,
          // ignore: deprecated_member_use
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              onGoogleSignIn(context);
            },
            color: isUserSignedIn ? Colors.green : Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.account_circle, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    isUserSignedIn ? 'You\'re logged in with Google' : 'Login with Google', 
                    style: const TextStyle(color: Colors.white))
                ],
              )
            )
          )
        )
      )
      );
  }
}