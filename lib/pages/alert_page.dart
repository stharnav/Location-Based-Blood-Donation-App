import 'package:flutter/material.dart';
import 'package:medical_help/database/firestore.dart';

class AlertPage extends StatelessWidget {
  final FirestoreDatabaser database = FirestoreDatabaser();
  AlertPage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text('Alerts'),),
      body: StreamBuilder(
                    stream: database.getAlertStream(), 
                    builder: (context,snapshot){   
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      if(snapshot.hasError){
                        return Text('Error: ${snapshot.error}');
                      }
                      if(snapshot.hasError){
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No messages.'));
                      }
                      final post = snapshot.data!.docs;
                      
                      return ListView.builder(
                        itemCount: post.length,
                        itemBuilder: (context, index){
                          return  Card(
                            margin: EdgeInsets.all(5),
                            elevation: 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(post[index]['message_title']),
                                subtitle: Text('${(post[index]['message_type'])} required near ${(post[index]['area'])}\nblood group ${(post[index]['blood_group'])} in ${(post[index]['hospital'])}'),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: (){},
                              ),
                            ),
                          );
                        }, 
                      );
                        },
                  )
    );
  }
}