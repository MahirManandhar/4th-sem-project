import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/admin/update_details/update_details.dart';
import 'package:flutter/material.dart';

final collRef = FirebaseFirestore.instance;
Future updateTeacher(TeacherModel tch, email) async {
  await collRef
      .collection('Teachers')
      .doc(email)
      .update(tch.toJson())
      .whenComplete(() => const Text('Updated Successfully'));
}

class UpdateTeacher extends StatefulWidget {
  const UpdateTeacher({super.key});

  @override
  State<UpdateTeacher> createState() => _UpdateTeacherState();
}

class _UpdateTeacherState extends State<UpdateTeacher> {
  TextEditingController esearch = TextEditingController();

  TextEditingController fncontroller = TextEditingController();
  TextEditingController mncontroller = TextEditingController();
  TextEditingController lncontroller = TextEditingController();
  TextEditingController sbjtcontroller = TextEditingController();
  TextEditingController acontroller = TextEditingController();
  TextEditingController pncontroller = TextEditingController();
  TextEditingController econtroller = TextEditingController();
  TextEditingController pwcontroller = TextEditingController();
  TextEditingController cpwcontroller = TextEditingController();

  String? email;

  void _loadTeacherData() async {
    if (email != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("Teachers")
          .doc(email)
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          fncontroller.text = documentSnapshot['Name.First'].toString();
          mncontroller.text = documentSnapshot['Name.Middle'].toString();
          lncontroller.text = documentSnapshot['Name.Last'].toString();
          sbjtcontroller.text = documentSnapshot['Subject'].toString();
          acontroller.text = documentSnapshot['Address'].toString();
          pncontroller.text = documentSnapshot['Phone no'].toString();
          econtroller.text = documentSnapshot['Email'].toString();
          pwcontroller.text = documentSnapshot['Password'].toString();
        });
      } else {
        setState(() {
          fncontroller.text = 'Error';
          mncontroller.text = 'Error';
          lncontroller.text = 'Error';
          sbjtcontroller.text = 'Error';
          acontroller.text = 'Error';
          pncontroller.text = 'Error';
          econtroller.text = 'Error';
          pwcontroller.text = 'Error';
        });
      }
    } else {
      print(const Text('Error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Text(
              'UPDATE TEACHER',
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
                  style: const TextStyle(
                    fontFamily: 'FiraSans',
                    fontSize: 25,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter email',
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
                      backgroundColor: const Color.fromRGBO(94, 110, 100, 100),
                      foregroundColor:
                          const Color.fromRGBO(255, 255, 255, 0.612),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        email = esearch.toString();
                        _loadTeacherData();
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
                const Divider(
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(
                  height: 15,
                ),
                nameField("First name", fncontroller),
                nameField("Middle name", mncontroller),
                nameField("Last name", lncontroller),
                nameField("Subject", sbjtcontroller),
                nameField("Address", acontroller),
                phoneField("Phone no", pncontroller),
                emailField("Email", econtroller),
                pwField("Password", pwcontroller),
                cpwField("Confirm password", cpwcontroller, pwcontroller),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(94, 110, 100, 100),
                      foregroundColor:
                          const Color.fromRGBO(255, 255, 255, 0.612),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.upgrade),
                    label: const Text(
                      'Update',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 25,
                      ),
                    ))
              ],
            ),
          ]),
        )));
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
        if (ctlr != pw) {
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
