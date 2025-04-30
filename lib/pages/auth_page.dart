import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_help/main.dart';
import 'package:medical_help/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          //user loggedin
          if(snapshot.hasData){
            return Root();
          }else{//user logged out
            return LoginPage();
          }
          
        }
        ),
    );
  }
}