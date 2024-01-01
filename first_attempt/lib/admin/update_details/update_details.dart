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
  final String phoneno;
  final String email;
  final String password;

  const StudentModel({
    required this.cls,
    required this.fn,
    required this.mn,
    required this.ln,
    required this.rollno,
    required this.address,
    required this.guardian,
    required this.phoneno,
    required this.email,
    required this.password,
  });

  toJson() {
    return {
      "Class": cls,
      "Name First": fn,
      "Name Middle": mn,
      "Name Last": ln,
      "Roll no": rollno,
      "Address": address,
      "Guardian": guardian,
      "Phone no": phoneno,
      "Email": email,
      "Password": password,
    };
  }
}

class TeacherModel {
  final String fn;
  final String mn;
  final String ln;
  final String subject;
  final String address;
  final String phoneno;
  final String email;
  final String password;

  const TeacherModel({
    required this.fn,
    required this.mn,
    required this.ln,
    required this.subject,
    required this.address,
    required this.phoneno,
    required this.email,
    required this.password,
  });

  toJson() {
    return {
      "Name First": fn,
      "Name Middle": mn,
      "Name Last": ln,
      "Subject": subject,
      "Address": address,
      "Phone no": phoneno,
      "Email": email,
      "Password": password,
    };
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
            const Padding(padding: EdgeInsets.symmetric(vertical: 70)),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(70),
                  backgroundColor: const Color.fromRGBO(94, 110, 100, 100),
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 0.612),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddStudent()));
                },
                icon: const Icon(
                  Icons.add,
                ),
                label: const Text(
                  'Add New Student',
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
                  fixedSize: const Size.fromHeight(70),
                  backgroundColor: const Color.fromRGBO(94, 110, 100, 100),
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 0.612),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddTeacher()));
                },
                icon: const Icon(
                  Icons.add,
                ),
                label: const Text(
                  'Add New Teacher',
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
                  fixedSize: const Size.fromHeight(70),
                  backgroundColor: const Color.fromRGBO(94, 110, 100, 100),
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 0.612),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateStudent()));
                },
                icon: const Icon(
                  Icons.person,
                ),
                label: const Text(
                  'Update Student Details',
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
                  fixedSize: const Size.fromHeight(70),
                  backgroundColor: const Color.fromRGBO(94, 110, 100, 100),
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 0.612),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateTeacher()));
                },
                icon: const Icon(
                  Icons.person,
                ),
                label: const Text(
                  'Update Teacher Details',
                  style: TextStyle(
                    fontFamily: 'FiraSans',
                    fontSize: 25,
                  ),
                )),
            //TextButton.icon(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>()))}, icon: const Icon(Icons.add), label: const Text('')),
          ],
        ),
      ),
    );
  }
}
