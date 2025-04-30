import 'package:flutter/material.dart';
import 'package:medical_help/database/firestore.dart';
import 'package:medical_help/database/userdata.dart';
import 'package:medical_help/pages/alert_page.dart';
import 'package:medical_help/pages/auth_page.dart';
import 'package:medical_help/pages/home_page.dart';
import 'package:medical_help/pages/news_page.dart';
import 'package:medical_help/pages/profile_page.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


String? _selectedBloodGroup;
String? _selectedHospital;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase start
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //forebase messaging
  await FirebaseApi().initNotification();
  
  fetchUserData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: AuthPage(),
      );
  }
}

class Root extends StatefulWidget {

  const Root({super.key});
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  final FirestoreDatabaser database = FirestoreDatabaser();

  int currentPage = 0;
  
  List<Widget> pages = [
    HomePage(),
    NewsPage(),
    AlertPage(), 
    ProfilePage(),
  ]; 

  

void quickAction() {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    // Close the current dialog and show the actual dialog with form
                    Navigator.pop(context);
                    createBloodRequest(context);
                  },
                  child: Text('Create Blood Request', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        );
      },
    );
}

// Full dialog content (blood group dropdown, hospital dropdown, etc.)
  void createBloodRequest(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9, // 90% screen width
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Create blood request', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Select required blood group and hospital'),
                SizedBox(height: 10),
                BloodGroupDropdown(), // Your widget for blood group selection
                HospitalDropdown(), // Your widget for hospital selection
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Assuming you have a valid blood group and hospital selection
                        database.addPost(_selectedBloodGroup!, 'Kathmandu', _selectedHospital!); // replace with actual values
                        Navigator.pop(context); // Close the dialog after posting
                      },
                      child: Text('Post'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: quickAction,
        child: Icon(Icons.add),
        ),
        body: pages[currentPage],
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home),label: 'Home'),
            NavigationDestination(icon: Icon(Icons.newspaper),label: 'News'),
            NavigationDestination(icon: Icon(Icons.notification_important),label: 'Alerts'),
            NavigationDestination(icon: Icon(Icons.face),label: 'Profile'),
          ],
        onDestinationSelected: (int index){
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
        ),
    );
  }
}


class BloodGroupDropdown extends StatefulWidget {
  const BloodGroupDropdown({super.key});

  @override
  State<BloodGroupDropdown> createState() => _BloodGroupDropdownState();
}

class _BloodGroupDropdownState extends State<BloodGroupDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
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
                );
  }
}

class HospitalDropdown extends StatefulWidget {
  const HospitalDropdown({super.key});

  @override
  State<HospitalDropdown> createState() => _HospitalDropdownState();
}

class _HospitalDropdownState extends State<HospitalDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
                  value: _selectedHospital,
                  hint: Text('Select Hospital'),
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Patan Hospital',
                      child: Text('Patan Hospital'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Kathmandu Hospital',
                      child: Text('Kathmandu Hospital'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedHospital = newValue;
                    });
                  },
                );
  }
}