import 'package:first_attempt/admin/update_details/add_student.dart';
import 'package:first_attempt/admin/update_details/add_teacher.dart';
import 'package:first_attempt/admin/update_details/update_student.dart';
import 'package:first_attempt/admin/update_details/update_teacher.dart';
import 'package:flutter/material.dart';

class UpdateDetails extends StatelessWidget {
  const UpdateDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 100)),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateStudent()));
                },
                icon: const Icon(Icons.person),
                label: const Text('Update Student Details')),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateTeacher()));
                },
                icon: const Icon(Icons.person),
                label: const Text('Update Teacher Details')),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddStudent()));
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Student')),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddTeacher()));
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Teacher')),
            //TextButton.icon(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>()))}, icon: const Icon(Icons.add), label: const Text('')),
          ],
        ),
      ),
    );
  }
}
