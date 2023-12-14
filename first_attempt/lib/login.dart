import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_attempt/admin/admin.dart';
import 'package:first_attempt/student/student.dart';
import 'package:first_attempt/teacher/teacher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late Future<FirebaseApp> _firebaseApp;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> _initializeFirebase() async {
    _firebaseApp = Firebase.initializeApp();
  }

  static Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found" || e.code == "wrong-password") {
        print("Wrong credentials");
      }
    }

    return user;
  }

  void _redirectToRole(User user) {
    String email = user.email ?? '';
    if (email.endsWith('@student.ps.edu.np')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Student()),
      );
    } else if (email.endsWith('@teacher.ps.edu.np')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Teacher()),
      );
    } else if (email.endsWith('@admin.ps.edu.np')) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Admin()),
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildLoginScreen(context);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildLoginScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(131, 151, 136, 1.0),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.18,
                left: 27,
                right: 35,
              ),
              child: Image(image: AssetImage('assets/images/logo.png')),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.4,
                left: 35,
                right: 35,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      color: Color.fromRGBO(6, 10, 8, 0.612),
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(255, 255, 255, 1),
                      filled: true,
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _passwordController,
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      color: Color.fromRGBO(6, 10, 8, 0.612),
                      fontSize: 20,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
                          primary: Color.fromRGBO(94, 110, 100, 100),
                          onPrimary: Color.fromRGBO(255, 255, 255, 0.612),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () async {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            _showErrorDialog('Fill all the fields');
                          } else {
                            User? user = await loginUsingEmailPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                              context: context,
                            );
                            print(user);
                            if (user != null) {
                              _redirectToRole(user);
                            } else {
                              _showErrorDialog('Credentials do not match');
                            }
                          }
                        },
                        child: const Text(
                          'Log In',
                          style:
                              TextStyle(fontFamily: 'FiraSans', fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
