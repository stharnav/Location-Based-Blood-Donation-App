// Declare universal variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String Global_firstName = "User";
late int Global_userAge;
String Global_bloodGroup = "A+";
String Global_lastName = "User";

// Function to fetch and save data
final user = FirebaseAuth.instance.currentUser!;
Future<int> fetchUserData() async {
  try {
    print(user.email);
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get();
        
    if (snapshot.exists) {
      var data = snapshot.data()!;
      
      // Save fetched data to universal variables
      Global_firstName = data['first_name'] ?? 'Unknown';
      Global_userAge = data['age'] ?? 0;
      Global_bloodGroup = data['blood_group'] ?? 'A+';
      Global_lastName = data['last_name'] ?? 'Unknown';
      
      print("User Data Fetched Successfully!");
    } else {
      print("No such user found.");
    }
  } catch (e) {
    print("Error fetching user data: $e");
  }
  return 1;
}
