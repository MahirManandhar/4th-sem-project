//import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/admin/update_details/update_details.dart';
import 'package:flutter/material.dart';

final collRef = FirebaseFirestore.instance;
Future updateStudent(StudentModel std, cls, email) async {
  await collRef
      .collection("Class")
      .doc(cls)
      .collection("Students")
      .doc(email)
      .update(std.toJson())
      .whenComplete(() => const Text('Updated successfully'));
}

class UpdateStudent extends StatefulWidget {
  const UpdateStudent({super.key});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final clscontroller = TextEditingController();
  final econtroller = TextEditingController();

  late DocumentSnapshot studentData;
  Future search(cls, email) async {
    await collRef
        .collection('Class')
        .doc(cls)
        .collection('Students')
        .doc(email)
        .get()
        .then((value) {
      studentData = value;
    });
    return studentData;
  }

  late final fncontroller =
      TextEditingController(text: studentData['Name.First']);
  late final mncontroller =
      TextEditingController(text: studentData['Name.Middle']);
  late final lncontroller =
      TextEditingController(text: studentData['Name.Last']);
  late final rncontroller = TextEditingController(text: studentData['Roll no']);
  late final gcontroller = TextEditingController(text: studentData['Guardian']);
  late final acontroller = TextEditingController(text: studentData['Address']);
  late final pncontroller =
      TextEditingController(text: studentData['Phone no']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Text('UPDATE STUDENT'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Stack(children: [
            Column(
              children: [
                TextFormField(
                  controller: clscontroller,
                  decoration: InputDecoration(
                    labelText: 'Class',
                    hintText: 'Enter Class',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: econtroller,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      search(clscontroller, econtroller);
                    },
                    icon: const Icon(Icons.search),
                    label: const Text('Search')),
                const Divider(
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                // TextFormField(
                //   initialValue: rollno,
                // )
              ],
            ),
            inputField("First name", fncontroller),
            inputField("Middle name", mncontroller),
            inputField("Last name", lncontroller),
            inputField("Roll no", rncontroller),
            inputField("Guardian", gcontroller),
            inputField("Address", acontroller),
            inputField("Phone no", pncontroller)
          ]),
        ));
  }
}

Widget inputField(String attribute, final ctlr) {
  return Column(children: [
    TextFormField(
      controller: ctlr,
      decoration: InputDecoration(
          labelText: attribute,
          hintText: 'Enter your $attribute',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    ),
    const SizedBox(
      height: 15,
    )
  ]);
}
