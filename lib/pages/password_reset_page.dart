import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_help/components/my_text_field.dart';

class PasswordResetPage extends StatefulWidget {
   const PasswordResetPage({super.key});
   

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {

   final emailController = TextEditingController();

  void forgetPassword()async{
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    //try sign in
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
      Navigator.pop(context);
       Navigator.pop(context);
      showDialog(context: context, builder: (context){
        return AlertDialog(title: const Text('Password reset email sent'),);
      });
    }on FirebaseAuthException catch(e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context){
        return AlertDialog(title: Text(e.code),);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            MyTextField(
              controller: emailController,
              hintText: 'Email', obscureText: false,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: forgetPassword,
              child: const Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}