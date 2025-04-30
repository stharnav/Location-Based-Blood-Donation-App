import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_help/components/my_text_field.dart';

class SignUpPage extends StatefulWidget {

   const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
   final fNameController = TextEditingController();
   final lNameController = TextEditingController();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final confirmPasswordController = TextEditingController();
   String? _selectedBloodGroup;

   void createNewAccount() async {
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    //try sign up
    try{
      if(fNameController.text.isEmpty || lNameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty || _selectedBloodGroup == null){
        Navigator.pop(context);
        showDialog(context: context, builder: (context){
          return AlertDialog(title: const Text('All fields are required'),);
        });
        return;
      }
      if(passwordController.text != confirmPasswordController.text){
        Navigator.pop(context);
        showDialog(context: context, builder: (context){
          return AlertDialog(title: const Text('Passwords do not match'),);
        });
        return;
      }
      if(passwordController.text.length < 6){
        Navigator.pop(context);
        showDialog(context: context, builder: (context){
          return AlertDialog(title: const Text('Password must be at least 6 characters long'),);
        });
        return;
      }
      //create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //add user documents
      createUserDocument();
      Navigator.pop(context);
      Navigator.pop(context);
      showDialog(context: context, builder: (context){
        return AlertDialog(title: const Text('Account created successfully'),);
      });
        
    }on FirebaseAuthException catch(e) {
      Navigator.pop(context);
      showDialog(context: context, builder: (context){
       return AlertDialog(title: Text(e.code),);
      });
    }  
  }

  //user document
  void createUserDocument() async {
    final user = FirebaseAuth.instance.currentUser;
    try{
      await FirebaseFirestore.instance.collection('users').doc(emailController.text).set({
        'first_name': fNameController.text,
        'last_name': lNameController.text,
        'blood_group': _selectedBloodGroup,
      });
    } on FirebaseException catch(e){
      debugPrint(e.code);
    }
    
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create new Account'),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyTextField(controller: fNameController, hintText: 'First Name', obscureText: false),
              SizedBox(height: 10,),
              MyTextField(controller: lNameController, hintText: 'Last Name', obscureText: false),
              SizedBox(height: 10,),
              MyTextField(controller: emailController, hintText: 'Email', obscureText: false),
              SizedBox(height: 10,),
              Row(
                children: [
                  DropdownButton<String>(
                    value: _selectedBloodGroup,
                    hint: Text('Select Blood Group'),
                    items: [
                      DropdownMenuItem<String>(
                        value: 'A+',
                        child: Text('A+'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'A-',
                        child: Text('A-'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'B+',
                        child: Text('B+'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'B-',
                        child: Text('B-'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'AB+',
                        child: Text('AB+'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'AB-',
                        child: Text('AB-'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'O+',
                        child: Text('O+'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'O-',
                        child: Text('O-'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBloodGroup = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Text('Password must be at least 6 characters long', style: TextStyle(color: Colors.grey[700], fontSize: 12),),
              SizedBox(height: 10,),
              MyTextField(controller: passwordController, hintText: 'password', obscureText: true),
              SizedBox(height: 10,),
              MyTextField(controller: confirmPasswordController, hintText: 'confirm password', obscureText: true),
              SizedBox(height: 30,),
              OutlinedButton(
                      onPressed: createNewAccount, 
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 153, 187),
                        minimumSize: Size(double.infinity, 50), // पूरै चौडा बटन (Parent अनुसार)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // किनारा गोलो बनाउने
                        ),
                        padding: EdgeInsets.symmetric(vertical: 25), // माथि-तल खाली ठाउँ
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}