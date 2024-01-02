import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_attempt/admin/update_details/update_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final collRef = FirebaseFirestore.instance;
Future createStudent(
    StudentModel std, email, password, BuildContext context) async {
  try {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await collRef
        .collection('Students')
        .doc(email)
        .set(std.toJson())
        .whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Center(
            child: Text("Student added successfully",
                style: TextStyle(fontFamily: 'FiraSans'))),
        duration: Duration(seconds: 3),
      ));
    });

    return credential.user;
  } catch (e) {
    debugPrint("Some error occured");
  }
}

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final clscontroller = TextEditingController();
  final fncontroller = TextEditingController();
  final mncontroller = TextEditingController();
  final lncontroller = TextEditingController();
  final rncontroller = TextEditingController();
  final gcontroller = TextEditingController();
  final acontroller = TextEditingController();
  final pncontroller = TextEditingController();
  final econtroller = TextEditingController();
  final pwcontroller = TextEditingController();
  final cpwcontroller = TextEditingController();

  @override
  void dispose() {
    econtroller.dispose();
    pwcontroller.dispose();
    cpwcontroller.dispose();
    pncontroller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            'ADD STUDENT',
            style: TextStyle(
              fontFamily: 'FiraSans',
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Stack(
            children: [
              Center(
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 70,
                    child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "Sorry, this feauture is currently unavailable.",
                                      style: TextStyle(
                                        fontFamily: 'FiraSans',
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: 35,
                        ))),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 170, horizontal: 15),
                child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        numField('Class', clscontroller),
                        nameField('First name', fncontroller),
                        mnameField('Middle name', mncontroller),
                        nameField('Last name', lncontroller),
                        numField('Roll no', rncontroller),
                        nameField('Guardian', gcontroller),
                        nameField('Address', acontroller),
                        phoneField('Phone no', pncontroller),
                        emailField('Email', econtroller),
                        pwField('Password', pwcontroller),
                        cpwField(
                            'Confirm password', cpwcontroller, pwcontroller),
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
                                createStudent(
                                    std, std.email, pwcontroller.text, context);
                              }
                            },
                            icon: const Icon(
                              Icons.person_add_alt_rounded,
                            ),
                            label: const Text(
                              'ADD',
                              style: TextStyle(
                                fontFamily: 'FiraSans',
                                fontSize: 25,
                              ),
                            ))
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
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

Widget pwField(String attribute, final ctlr) {
  return Column(children: [
    TextFormField(
      controller: ctlr,
      validator: (value) {
        if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+[0-9]+$').hasMatch(value)) {
          return "Please enter password";
        } else {
          return null;
        }
      },
      obscureText: true,
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

Widget cpwField(String attribute, final ctlr, final pw) {
  return Column(children: [
    TextFormField(
      controller: ctlr,
      validator: (value) {
        if (ctlr.text != pw.text) {
          return "Password do not match";
        } else {
          return null;
        }
      },
      obscureText: true,
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
