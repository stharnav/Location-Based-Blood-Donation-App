import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_help/components/my_text_field.dart';
import 'package:medical_help/database/userdata.dart';
import 'package:medical_help/pages/password_reset_page.dart';
import 'package:medical_help/pages/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign in method
  void signIn()async{
    showDialog(context: context, builder: (context){
      fetchUserData();
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    if (context.mounted) {
      Navigator.pop(context);
    }

    }on FirebaseAuthException catch(e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context){
        return AlertDialog(title: Text(e.code),);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Icon(Icons.lock, size: 30,),
                  SizedBox(height: 150),
                  Text(
                    'Lets get you in',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 10,),
                  MyTextField(controller: emailController, hintText: 'email', obscureText: false),
                  SizedBox(height: 10,),
                  MyTextField(hintText: 'password', obscureText: true, controller: passwordController,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordResetPage()));
                      }, child: Text('Forget Password?')),
                    ],
                  ),
                  SizedBox(height: 15,),
                  OutlinedButton(
                    onPressed: signIn, 
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 153, 187),
                      minimumSize: Size(double.infinity, 50), // पूरै चौडा बटन (Parent अनुसार)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // किनारा गोलो बनाउने
                      ),
                      padding: EdgeInsets.symmetric(vertical: 25), // माथि-तल खाली ठाउँ
                    ),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                      }, child: Text('Create new account'))
                    ],
                  ),
                  SizedBox(height: 140,),
                  Text('Continue with'),
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: OutlinedButton(
                      onPressed: (){}, 
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50), // पूरै चौडा बटन (Parent अनुसार)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // किनारा गोलो बनाउने
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15), // माथि-तल खाली ठाउँ
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/800px-Google_%22G%22_logo.svg.png',
                            height: 20, // Adjust size as needed
                            width: 20,
                          ),
                          SizedBox(width: 8), // Space between logo and text
                          Text(
                            'Google',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                 ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}