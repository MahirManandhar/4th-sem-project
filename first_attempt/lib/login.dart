import 'package:first_attempt/admin/admin.dart';
import 'package:first_attempt/student/student.dart';
import 'package:first_attempt/teacher/teacher.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(131, 151, 136, 1.0),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.27, left: 35),
              child: const Text(
                'WELCOME!',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4,
                  left: 35,
                  right: 35),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        fillColor: const Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Student()));
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1), fontSize: 25),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Teacher()));
                      },
                      child: const Text(
                        'Teacher',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1), fontSize: 25),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Admin()));
                      },
                      child: const Text(
                        'Admin',
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1), fontSize: 25),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
