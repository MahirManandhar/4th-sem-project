import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/admin/update_details/update_details.dart';
import 'package:flutter/material.dart';

final collRef = FirebaseFirestore.instance;

Future createStudent(TeacherModel std) async {
  await collRef
      .collection('Teachers')
      .add(std.toJson())
      .whenComplete(() => const Text('Added successfully'));
}

class AddTeacher extends StatelessWidget {
  AddTeacher({super.key});

  final tchidcontroller = TextEditingController();
  final fncontroller = TextEditingController();
  final mncontroller = TextEditingController();
  final lncontroller = TextEditingController();
  final sbjtcontroller = TextEditingController();
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
          child: Text('ADD TEACHER'),
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
                    inputField('Teacher Id', tchidcontroller),
                    inputField('First name', fncontroller),
                    inputField('Middle name', mncontroller),
                    inputField('Last name', lncontroller),
                    inputField('Subject', sbjtcontroller),
                    inputField('Address', acontroller),
                    inputField('Email', econtroller),
                    inputField('Phone no', pncontroller),
                    ElevatedButton.icon(
                        onPressed: () {
                          final tch = TeacherModel(
                              tchid: tchidcontroller.text.trim(),
                              fn: fncontroller.text.trim(),
                              mn: mncontroller.text.trim(),
                              ln: lncontroller.text.trim(),
                              subject: sbjtcontroller.text.trim(),
                              address: acontroller.text.trim(),
                              email: econtroller.text.trim(),
                              phoneno: pncontroller.text.trim());

                          createStudent(tch);
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
