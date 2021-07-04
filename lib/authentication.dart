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
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(Icons.ac_unit),
        onPressed: () {
          //TODO
        },
      ),
    );
  }
}
