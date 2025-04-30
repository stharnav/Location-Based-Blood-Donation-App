import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_help/database/userdata.dart';
import 'package:medical_help/pages/edit_profile_page.dart';
import 'package:medical_help/pages/password_reset_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  void signOut(){
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg'), 
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Global_firstName+' '+Global_lastName, style: TextStyle(fontSize: 20),),
                      Text(user.email as String),
                    ],
                  ),
                  
                ],
              ),
            ),
             ListTile(
              leading: Icon(Icons.face_retouching_natural),
              title: Text('Edit Profile'),
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Security'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordResetPage()));
              },
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: signOut,
            ),
            ElevatedButton(onPressed: (){
              fetchUserData();
            }, child: Icon(Icons.abc))
          ],
        ),
      ),
    );
  }
}