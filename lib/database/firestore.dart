

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:medical_help/database/userdata.dart';
import 'package:medical_help/pages/alert_page.dart';

class FirestoreDatabaser{
  //curernt user
  User? user = FirebaseAuth.instance.currentUser;

  //get colelction of post from firestore
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  //post a message
  Future<void> addPost(String bloodGroup, String area, String hospital) {
    return posts.add({
      'user': user!.email,
      'message_title': 'Blood required',
      'message_type':'Blood',
      'blood_group': bloodGroup,
      'area': area,
      'hospital': hospital,
      'created_at': FieldValue.serverTimestamp()
    });
  }
  
  //read post from database
  Stream<QuerySnapshot>getPostStream(){
    final postStream = FirebaseFirestore.instance.collection('posts').snapshots();
    return postStream;
  }

  //read alert message from database
  Stream<QuerySnapshot>getAlertStream(){
    final postStream = FirebaseFirestore.instance
    .collection('posts')
    .where('blood_group', isEqualTo: Global_bloodGroup)
    //.where('location', isNotEqualTo: 'Kathmandu')
    .snapshots();
    return postStream;
  }

  
}



class FirebaseApi{
   //create instance of Firebase messaging
   final _firebaseMessaging = FirebaseMessaging.instance;
  // Define navigatorKey
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
     //function to initialize notification
   Future<void> initNotification() async{
    //request permission
    await _firebaseMessaging.requestPermission();

    //fetch token
    final token = await _firebaseMessaging.getToken();
    print('Token: ${(token)}');

    //init pusn notification
    initPushNotifications();
   }
   //function to handle received message
   void handleMessage(RemoteMessage? message){
    print('Notification clicked ${(message)}'); 
    if (message != null) {
       if (navigatorKey.currentState != null) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (context) => AlertPage()),
        );
      }
    }
   }
   //function to handle foreground and backgound handling 
   Future initPushNotifications() async{
    //if app closed
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    //if app opened
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
   }
}