import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/admin/update_details/update_details.dart';
import 'package:flutter/material.dart';

final collRef = FirebaseFirestore.instance;
Future updateStudent(StudentModel std, email, BuildContext context) async {
  await collRef
      .collection('Students')
      .doc(email)
      .update(std.toJson())
      .whenComplete(() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Center(
        child: Text("Updated successfully",
            style: TextStyle(fontFamily: 'FiraSans')),
      ),
      duration: Duration(seconds: 3),
    ));
  });
}

Future deleteStudent(email, BuildContext context) async {
      await collRef.collection('Students').doc(email).delete().whenComplete(() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Center(
        child: Text("Deleted successfully",
            style: TextStyle(fontFamily: 'FiraSans')),
      ),
      duration: Duration(seconds: 3),
    ));
  });
}

class UpdateStudent extends StatefulWidget {
  const UpdateStudent({super.key});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  TextEditingController esearch = TextEditingController();

  TextEditingController clscontroller = TextEditingController();
  TextEditingController fncontroller = TextEditingController();
  TextEditingController mncontroller = TextEditingController();
  TextEditingController lncontroller = TextEditingController();
  TextEditingController rncontroller = TextEditingController();
  TextEditingController gcontroller = TextEditingController();
  TextEditingController acontroller = TextEditingController();
  TextEditingController pncontroller = TextEditingController();
  TextEditingController econtroller = TextEditingController();
  TextEditingController pwcontroller = TextEditingController();
  TextEditingController cpwcontroller = TextEditingController();

  String? email;

  void _loadStudentData() async {
    if (email != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Students')
          .doc(email)
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          clscontroller.text = documentSnapshot['Class'].toString();
          fncontroller.text = documentSnapshot['Name First'].toString();
          mncontroller.text = documentSnapshot['Name Middle'].toString();
          lncontroller.text = documentSnapshot['Name Last'].toString();
          rncontroller.text = documentSnapshot['Roll no'].toString();
          gcontroller.text = documentSnapshot['Guardian'].toString();
          acontroller.text = documentSnapshot['Address'].toString();
          pncontroller.text = documentSnapshot['Phone no'].toString();
          econtroller.text = documentSnapshot['Email'].toString();
        });
      } else {
        setState(() {
          clscontroller.text = 'Error';
          fncontroller.text = 'Error';
          mncontroller.text = 'Error';
          lncontroller.text = 'Error';
          rncontroller.text = 'Error';
          gcontroller.text = 'Error';
          acontroller.text = 'Error';
          pncontroller.text = 'Error';
          econtroller.text = 'Error';
        });
      }
    } else {
      debugPrint('Error');
    }
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Text(
              'UPDATE STUDENT',
              style: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 25,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Stack(children: [
              Column(
                children: [
                  TextFormField(
                    controller: esearch,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 25,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(94, 110, 100, 100),
                        foregroundColor:
                            const Color.fromRGBO(255, 255, 255, 0.612),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          email = esearch.text.trim();
                          _loadStudentData();
                        });
                      },
                      icon: const Icon(Icons.search),
                      label: const Text(
                        'Search',
                        style: TextStyle(
                          fontFamily: 'FiraSans',
                          fontSize: 25,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 3,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          numField("Class", clscontroller),
                          nameField("First name", fncontroller),
                          mnameField("Middle name", mncontroller),
                          nameField("Last name", lncontroller),
                          numField("Roll no", rncontroller),
                          nameField("Guardian", gcontroller),
                          nameField("Address", acontroller),
                          phoneField("Phone no", pncontroller),
                          emailField("Email", econtroller),
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(94, 110, 100, 100),
                        foregroundColor:
                            const Color.fromRGBO(255, 255, 255, 0.612),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          final std = StudentModel(
                            cls: clscontroller.text.trim(),
                            fn: fncontroller.text.trim(),
                            mn: mncontroller.text.trim(),
                            ln: lncontroller.text.trim(),
                            rollno: rncontroller.text.trim(),
                            address: acontroller.text.trim(),
                            guardian: gcontroller.text.trim(),
                            phoneno: pncontroller.text.trim(),
                            email: econtroller.text.trim(),
                          );

                          updateStudent(std, std.email, context);
                        }
                      },
                      icon: const Icon(Icons.upgrade),
                      label: const Text(
                        'Update',
                        style: TextStyle(
                          fontFamily: 'FiraSans',
                          fontSize: 25,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(94, 110, 100, 100),
                        foregroundColor:
                            const Color.fromRGBO(255, 255, 255, 0.612),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        deleteStudent(econtroller.text.trim(), context);
                      },
                      icon: const Icon(Icons.delete_forever),
                      label: const Text(
                        'Delete',
                        style: TextStyle(
                          fontFamily: 'FiraSans',
                          fontSize: 25,
                        ),
                      ))
                ],
              ),
            ]),
          ),
        ));
  }
}

Widget nameField(String attribute, final ctlr) {
  return Column(children: [
    TextFormField(
      controller: ctlr,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
          return "Please enter correct name";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.name,
      style: const TextStyle(
        fontFamily: 'FiraSans',
        fontSize: 25,
      ),
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

Widget mnameField(String attribute, final ctlr) {
  return Column(children: [
    TextFormField(
      controller: ctlr,
      keyboardType: TextInputType.name,
      style: const TextStyle(
        fontFamily: 'FiraSans',
        fontSize: 25,
      ),
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

Widget numField(String attribute, final ctlr) {
  return Column(children: [
    TextFormField(
      controller: ctlr,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter correct number";
        } else {
          return null;
        }
      },
      style: const TextStyle(
        fontFamily: 'FiraSans',
        fontSize: 25,
      ),
      keyboardType: TextInputType.text,
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

Widget emailField(String attribute, final ctlr) {
  return Column(children: [
    TextFormField(
      controller: ctlr,
      validator: (value) {
        if (value!.isEmpty ||
            !RegExp(r'^[\w-\.]+@student.ps.edu.np').hasMatch(value)) {
          return "Please enter correct email";
        } else {
          return null;
        }
      },
      style: const TextStyle(
        fontFamily: 'FiraSans',
        fontSize: 25,
      ),
      keyboardType: TextInputType.emailAddress,
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

Widget phoneField(String attribute, final ctlr) {
  return Column(children: [
    TextFormField(
      controller: ctlr,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[-\s\./0-9]+$').hasMatch(value)) {
          return "Please enter correct phone no";
        } else {
          return null;
        }
      },
      style: const TextStyle(
        fontFamily: 'FiraSans',
        fontSize: 25,
      ),
      keyboardType: TextInputType.number,
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
