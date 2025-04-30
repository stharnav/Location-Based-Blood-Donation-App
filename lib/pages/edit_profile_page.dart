import 'package:flutter/material.dart';
import 'package:medical_help/components/my_text_field.dart';
import 'package:medical_help/database/userdata.dart';
import 'package:medical_help/location_services.dart';

class EditProfilePage extends StatelessWidget {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  LocationServices locationServices = LocationServices();
  EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            MyTextField(controller: firstName, hintText: Global_firstName , obscureText: false),
            SizedBox(height: 20,),
            MyTextField(controller: lastName, hintText: Global_lastName , obscureText: false),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){},
              child: const Text('Save'),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                FutureBuilder(
                  future: locationServices.initializeLocation(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      var data = snapshot.data as List?;
                      return Text('City: ${data?[0]} \nLatitude: ${data?[1]} \nLongitude:${data?[2]}');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}