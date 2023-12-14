import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/admin/update_details/update_details.dart';
import 'package:flutter/material.dart';

final collRef = FirebaseFirestore.instance;

Future<TeacherModel> getTeacherDetails(String email) async {
  final snapshot = await collRef
      .collection('Teachers')
      .where("Email", isEqualTo: email)
      .get();
  final teacherData =
      snapshot.docs.map((e) => TeacherModel.fromSnapshot(e)).single;
  return teacherData;
}

class UpdateTeacher extends StatelessWidget {
  UpdateTeacher({super.key});

  final tchidcontroller =
      TextEditingController(text: TeacherModel.teacherData.tchid);
  final fncontroller = TextEditingController(text: TeacherModel.teacherData.fn);
  final mncontroller = TextEditingController(text: TeacherModel.teacherData.mn);
  final lncontroller = TextEditingController(text: TeacherModel.teacherData.ln);
  final sjbtcontroller =
      TextEditingController(text: TeacherModel.teacherData.subject);
  final acontroller =
      TextEditingController(text: TeacherModel.teacherData.address);
  final econtroller =
      TextEditingController(text: TeacherModel.teacherData.email);
  final pncontroller =
      TextEditingController(text: TeacherModel.teacherData.phoneno);

  final searchemail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Text('UPDATE TEACHER'),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: searchemail,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 75),
              child: Divider(
                thickness: 3,
                indent: 25,
                endIndent: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: FutureBuilder(
                  future: getTeacherDetails(searchemail as String),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 70,
                                  ),
                                  Positioned(
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add_a_photo)),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 220, horizontal: 15),
                              child: Column(
                                children: [
                                  inputField('TeacherId', tchidcontroller),
                                  inputField('First name', fncontroller),
                                  inputField('Middle name', mncontroller),
                                  inputField('Last name', lncontroller),
                                  inputField('Subject', sjbtcontroller),
                                  inputField('Address', acontroller),
                                  inputField('Email', econtroller),
                                  inputField('Phone no', pncontroller),
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        // final std = StudentModel(
                                        //     stdid: stdidcontroller.text.trim(),
                                        //     fn: fncontroller.text.trim(),
                                        //     mn: mncontroller.text.trim(),
                                        //     ln: lncontroller.text.trim(),
                                        //     rollno: rncontroller.text.trim(),
                                        //     address: acontroller.text.trim(),
                                        //     guardian: gcontroller.text.trim(),
                                        //     email: econtroller.text.trim(),
                                        //     phoneno: pncontroller.text.trim());

                                        // createStudent(std);
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
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      );
                    }
                  }),
            )
          ]),
        )));
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
