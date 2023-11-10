import 'package:first_attempt/login.dart';
import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 65),
          child: Text('PATHSHALA'),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 150),
            child: Center(
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                      child: const Text('Log Out',
                          style: TextStyle(color: Colors.black, fontSize: 23))),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('About Us',
                          style: TextStyle(color: Colors.black, fontSize: 23))),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text('Help',
                          style: TextStyle(color: Colors.black, fontSize: 23)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
