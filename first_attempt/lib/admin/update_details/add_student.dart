import 'package:first_attempt/admin/update_details/update_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final collRef = FirebaseFirestore.instance;

Future createStudent(StudentModel std, cls, email) async {
  await collRef
      .collection("Class")
      .doc(cls)
      .collection("Students")
      .doc(email)
      .set(std.toJson())
      .whenComplete(() => const Text('Added successfully'));
}

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  final clscontroller = TextEditingController();
  final fncontroller = TextEditingController();
  final mncontroller = TextEditingController();
  final lncontroller = TextEditingController();
  final rncontroller = TextEditingController();
  final gcontroller = TextEditingController();
  final acontroller = TextEditingController();
  final econtroller = TextEditingController();
  final pncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text('ADD STUDENT'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 70,
                  ),
                  Positioned(
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.add_a_photo)),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 175, horizontal: 15),
                child: Column(
                  children: [
                    inputField('Class', clscontroller),
                    inputField('First name', fncontroller),
                    inputField('Middle name', mncontroller),
                    inputField('Last name', lncontroller),
                    inputField('Roll no', rncontroller),
                    inputField('Guardian', gcontroller),
                    inputField('Address', acontroller),
                    inputField('Email', econtroller),
                    inputField('Phone no', pncontroller),
                    ElevatedButton.icon(
                        onPressed: () {
                          final std = StudentModel(
                              cls: clscontroller.text.trim(),
                              fn: fncontroller.text.trim(),
                              mn: mncontroller.text.trim(),
                              ln: lncontroller.text.trim(),
                              rollno: rncontroller.text.trim(),
                              address: acontroller.text.trim(),
                              guardian: gcontroller.text.trim(),
                              email: econtroller.text.trim(),
                              phoneno: pncontroller.text.trim());

                          createStudent(std, std.cls, std.email);
                        },
                        icon: const Icon(
                          Icons.person_add_alt_rounded,
                          color: Colors.black54,
                        ),
                        label: const Text(
                          'ADD',
                          style: TextStyle(color: Colors.black54),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
