import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/admin/update_details/add_student.dart';
import 'package:first_attempt/admin/update_details/add_teacher.dart';
import 'package:first_attempt/admin/update_details/update_student.dart';
import 'package:first_attempt/admin/update_details/update_teacher.dart';
import 'package:flutter/material.dart';

class StudentModel {
  final String cls;
  final String fn;
  final String mn;
  final String ln;
  final String rollno;
  final String address;
  final String guardian;
  final String email;
  final String phoneno;

  const StudentModel({
    required this.cls,
    required this.fn,
    required this.mn,
    required this.ln,
    required this.rollno,
    required this.address,
    required this.guardian,
    required this.email,
    required this.phoneno,
  });

  toJson() {
    return {
      "Class": cls,
      "Name.First": fn,
      "Name.Middle": mn,
      "Name.Last": ln,
      "Roll no": rollno,
      "Address": address,
      "Guardian": guardian,
      "Email": email,
      "Phone no": phoneno,
    };
  }

  factory StudentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StudentModel(
        cls: data["Class"],
        fn: data["Name.First"],
        mn: data["Name.Middle"],
        ln: data["Name.Last"],
        rollno: data["Roll no"],
        address: data["Address"],
        guardian: data["Guardian"],
        email: data["Email"],
        phoneno: data["Phone no"]);
  }
}

class TeacherModel {
  final String? id;
  final String tchid;
  final String fn;
  final String mn;
  final String ln;
  final String subject;
  final String address;
  final String email;
  final String phoneno;

  static var teacherData;

  const TeacherModel({
    this.id,
    required this.tchid,
    required this.fn,
    required this.mn,
    required this.ln,
    required this.subject,
    required this.address,
    required this.email,
    required this.phoneno,
  });

  toJson() {
    return {
      "Teacher Id": tchid,
      "Name.First": fn,
      "Name.Middle": mn,
      "Name.Last": ln,
      "Subject": subject,
      "Address": address,
      "Email": email,
      "Phone no": phoneno,
    };
  }

  factory TeacherModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TeacherModel(
        tchid: data["Teacher Id"],
        fn: data["Name.first"],
        mn: data["Name.Middle"],
        ln: data["Name.Last"],
        subject: data["Subject"],
        address: data["Address"],
        email: data["Email"],
        phoneno: data["Phone no"]);
  }
}

class UpdateDetails extends StatelessWidget {
  const UpdateDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 100)),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddStudent()));
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black87,
                ),
                label: const Text(
                  'Add New Student',
                  style: TextStyle(color: Colors.black87),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTeacher()));
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black87,
                ),
                label: const Text(
                  'Add New Teacher',
                  style: TextStyle(color: Colors.black87),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateStudent()));
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.black87,
                ),
                label: const Text(
                  'Update Student Details',
                  style: TextStyle(color: Colors.black87),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UpdateTeacher()));
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.black87,
                ),
                label: const Text(
                  'Update Teacher Details',
                  style: TextStyle(color: Colors.black87),
                )),
            //TextButton.icon(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>()))}, icon: const Icon(Icons.add), label: const Text('')),
          ],
        ),
      ),
    );
  }
}
