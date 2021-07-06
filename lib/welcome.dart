import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeUserWidget extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  final User user;
  const WelcomeUserWidget(
      {Key? key, required this.user, required this.googleSignIn})
      : super(key: key);

  @override
  _WelcomeUserWidgetState createState() => _WelcomeUserWidgetState();
}

class _WelcomeUserWidgetState extends State<WelcomeUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(50),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Image.network(
                  widget.user.photoURL!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover
                )
              ),
              const SizedBox(height: 20),
              const Text('Welcome,', textAlign: TextAlign.center),
              Text(widget.user.displayName!, textAlign: TextAlign.center, 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              const SizedBox(height: 20),
              // ignore: deprecated_member_use
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  widget.googleSignIn.signOut();
                  Navigator.pop(context, false);
                },
                color: Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const Icon(Icons.exit_to_app, color: Colors.white),
                      const SizedBox(width: 10),
                      const Text('Log out of Google', style: TextStyle(color: Colors.white))
                    ],
                  )
                )
              )
            ],
          )
        )
      )
    );
  }
}
