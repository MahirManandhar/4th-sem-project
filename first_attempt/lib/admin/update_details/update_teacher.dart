import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/admin/update_details/update_details.dart';
import 'package:flutter/material.dart';

final collRef = FirebaseFirestore.instance;
Future updateTeacher(TeacherModel tch, email, BuildContext context) async {
  await collRef
      .collection('Teachers')
      .doc(email)
      .update(tch.toJson())
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

Future deleteTeacher(email, BuildContext context) async {
  await collRef.collection('Teachers').doc(email).delete().whenComplete(() {
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
          .collection('Teachers')
          .doc(email)
          .get();
      if (documentSnapshot.exists) {
        setState(() {
          fncontroller.text = documentSnapshot['Name First'].toString();
          mncontroller.text = documentSnapshot['Name Middle'].toString();
          lncontroller.text = documentSnapshot['Name Last'].toString();
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
                  keyboardType: TextInputType.emailAddress,
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
                        email = esearch.text.trim();
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
                Form(
                    key: formkey,
                    child: Column(
                      children: [
                        nameField("First name", fncontroller),
                        mnameField("Middle name", mncontroller),
                        nameField("Last name", lncontroller),
                        nameField("Subject", sbjtcontroller),
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
                      backgroundColor: const Color.fromRGBO(94, 110, 100, 100),
                      foregroundColor:
                          const Color.fromRGBO(255, 255, 255, 0.612),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        final tch = TeacherModel(
                          fn: fncontroller.text.trim(),
                          mn: mncontroller.text.trim(),
                          ln: lncontroller.text.trim(),
                          subject: sbjtcontroller.text.trim(),
                          address: acontroller.text.trim(),
                          phoneno: pncontroller.text.trim(),
                          email: econtroller.text.trim(),
                        );
                        updateTeacher(tch, tch.email, context);
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
                      backgroundColor: const Color.fromRGBO(94, 110, 100, 100),
                      foregroundColor:
                          const Color.fromRGBO(255, 255, 255, 0.612),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      deleteTeacher(econtroller.text.trim(), context);
                    },
                    icon: const Icon(Icons.delete_forever),
                    label: const Text(
                      'Delete',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 25,
                      ),
                    )),
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

Widget emailField(String attribute, final ctlr) {
  return Column(children: [
    TextFormField(
      controller: ctlr,
      validator: (value) {
        if (value!.isEmpty ||
            !RegExp(r'^[\w-\.]+@teacher.ps.edu.np').hasMatch(value)) {
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
        if (value!.isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
          return "Please enter correct phone number";
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
