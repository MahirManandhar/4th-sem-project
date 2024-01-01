import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:first_attempt/components/textbox.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //final currentUser = FirebaseAuth.instance.currentUser!;
  final collRef = FirebaseFirestore.instance
      .collection("Class")
      .doc('3')
      .collection('Students');
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: StreamBuilder(
          stream: collRef
              .where("Email", isEqualTo: _auth.currentUser!.email)
              .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.black38,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 75,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_4_outlined),
                        title: Text(
                          "First Name: ${snapshot.data!.docs[index]["Name First"]}",
                          style: const TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 20,
                          ),
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_4_outlined),
                        title: Text(
                          "Middle Name: ${snapshot.data!.docs[index]["Name Middle"]}",
                          style: const TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 20,
                          ),
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_4_outlined),
                        title: Text(
                          "Last Name: ${snapshot.data!.docs[index]["Name Last"]}",
                          style: const TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 20,
                          ),
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const Icon(Icons.menu_book_outlined),
                        title: Text(
                          "Class: ${snapshot.data!.docs[index]["Class"]}",
                          style: const TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 20,
                          ),
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const Icon(Icons.menu_book_outlined),
                        title: Text(
                          "Roll no: ${snapshot.data!.docs[index]["Roll no"]}",
                          style: const TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 20,
                          ),
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        title: Text(
                          "Address: ${snapshot.data!.docs[index]["Address"]}",
                          style: const TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 20,
                          ),
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_4_outlined),
                        title: Text(
                          "Guardian: ${snapshot.data!.docs[index]["Guardian"]}",
                          style: const TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 20,
                          ),
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone_android_outlined),
                        title: Text(
                          "Phone no: ${snapshot.data!.docs[index]["Phone no"]}",
                          style: const TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 20,
                          ),
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const Icon(Icons.email_outlined),
                        title: Text(
                          "Email: ${snapshot.data!.docs[index]["Email"]}",
                          style: const TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 19,
                          ),
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ]);
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    ));
  }
}

// ListView(
//           //padding: const EdgeInsets.all(16.0),
//           children: [
//             // Profile picture
//             const CircleAvatar(
//               radius: 36,
//               child: Icon(Icons.person, size: 72),
//             ),

//             const SizedBox(height: 10),

//             // user email
//             Text(
//               currentUser.email!,
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Color.fromARGB(255, 13, 12, 12)),
//             ),

//             const SizedBox(height: 50),

//             //user details
//             Padding(
//               padding: const EdgeInsets.only(left: 25.0),
//               child: Text(
//                 'Personal Details',
//                 style: TextStyle(color: Colors.grey[200]),
//               ),
//             ),

//             //username
//             const MytextBox(text: 'Anusha', sectionName: 'Student_name'),

//             const MytextBox(text: '10', sectionName: 'Class'),

//             const MytextBox(text: '+9779845368563', sectionName: 'Contact'),

//             const MytextBox(text: 'Chitwan', sectionName: 'Address')
//           ],
//         ));
