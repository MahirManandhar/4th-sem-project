import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({super.key});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  final collRef = FirebaseFirestore.instance.collection("Teachers");
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
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.black38,
                            backgroundImage:
                                AssetImage('assets/images/logo.png'),
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
                            "Subject: ${snapshot.data!.docs[index]["Subject"]}",
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
                      ],
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    ));
  }
}
