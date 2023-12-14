import 'package:first_attempt/login.dart';
import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: AppBar(
              backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 150, height: 70),
                    child: const Image(image: AssetImage('assets/images/logo.png'))),
              )),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 150),
            child: Center(
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 160, height: 40),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary:const Color.fromRGBO(94, 110, 100, 100),
                            onPrimary:const Color.fromRGBO(255, 255, 255, 0.612),
                            elevation: 10, // Button elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: const Text('Log Out',
                            style: TextStyle(
                                fontFamily: 'FiraSans', fontSize: 25))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 160, height: 40),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary:const Color.fromRGBO(94, 110, 100, 100),
                            onPrimary:const Color.fromRGBO(255, 255, 255, 0.612),
                            elevation: 10, // Button elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        onPressed: () {},
                        child: const Text('About Us',
                            style: TextStyle(
                                fontFamily: 'FiraSans', fontSize: 25))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 160, height: 40),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary:const Color.fromRGBO(94, 110, 100, 100),
                            onPrimary:const Color.fromRGBO(255, 255, 255, 0.612),
                            elevation: 10, // Button elevation
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                        onPressed: () {},
                        child: const Text('Help',
                            style: TextStyle(
                                fontFamily: 'FiraSans', fontSize: 25))),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
