import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_attempt/components/textbox.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
      ),
      body: ListView(
       //padding: const EdgeInsets.all(16.0),
        children: [
          // Profile picture
          CircleAvatar(
            radius: 36,
            child: Icon(Icons.person, size: 72),
          ),

        
      
      const SizedBox(height: 10),

      // user email
      Text(
        currentUser.email!,
        textAlign: TextAlign.center,
        style: TextStyle (color: Color.fromARGB(255, 13, 12, 12)),
      ),

      const SizedBox(height:50),

      //user details
      Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child : Text (
          'Personal Details',
          style: TextStyle (color : Colors.grey[200]),

        ),
        ),

        //username
        MytextBox(
          text:'Anusha',
          sectionName: 'Student_name'),

        MytextBox(
          text: '10',
          sectionName: 'Class'),

        MytextBox(text: '+9779845368563', sectionName: 'Contact'),

        MytextBox(text: 'Chitwan', sectionName: 'Address')


        
        
        ],

        
        
      )
    );
  }
}