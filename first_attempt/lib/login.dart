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
                    top: MediaQuery.of(context).size.height * 0.18,
                    left: 27,
                    right: 35),
                child: const Image(image: AssetImage('assets/images/logo.png'))),
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
                        hintStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: const TextStyle(fontFamily: 'Quicksand', fontSize: 20),
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(width: 160, height: 40),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(94, 110, 100, 100),
                              onPrimary: const Color.fromRGBO(255, 255, 255, 0.612),
                              elevation: 10, // Button elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Student()));
                          },
                          child: const Text(
                            'Log In',
                            style:
                                TextStyle(fontFamily: 'FiraSans', fontSize: 25),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(width: 160, height: 40),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const  Color.fromRGBO(94, 110, 100, 100),
                              onPrimary: const Color.fromRGBO(255, 255, 255, 0.612),
                              elevation: 10, // Button elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Teacher()));
                          },
                          child: const Text(
                            'Teacher',
                            style:
                                TextStyle(fontFamily: 'FiraSans', fontSize: 25),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(width: 160, height: 40),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(94, 110, 100, 100),
                              onPrimary: const  Color.fromRGBO(255, 255, 255, 0.612),
                              elevation: 10, // Button elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Admin()));
                          },
                          child: const Text(
                            'Admin',
                            style:
                                TextStyle(fontFamily: 'FiraSans', fontSize: 25),
                          )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
