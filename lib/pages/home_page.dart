import 'package:flutter/material.dart';
import 'package:medical_help/database/userdata.dart';

class HomePage extends StatelessWidget {

  
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Hi '+Global_firstName, style: TextStyle(fontSize: 20),),
                subtitle: Text('How can we help you today?'),
              ),
            ),
            SizedBox(height: 20,),
             Card(
              child: ListTile(
                title: Text('My Requests', style: TextStyle(fontSize: 20),),
                subtitle: Text('No request yet'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: (){},
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
