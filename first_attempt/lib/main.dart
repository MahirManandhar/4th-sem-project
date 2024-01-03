import 'package:first_attempt/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:first_attempt/login.dart';
import 'package:first_attempt/aboutUs.dart';
import 'package:first_attempt/settings.dart';
import 'package:first_attempt/change_password.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
print('hhhhhhhhhhhh');
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(ThemeData.light()), // Initial theme
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // Assuming you get userId and email from somewhere
  final String userId = 'yourUserId';
  final String email = 'yourEmail';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeNotifier>(context).getTheme(),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const Login(),
        '/aboutus': (context) => const AboutUs(),
        '/settings': (context) => Settings(userId: userId, email: email),
        '/settings/changepassword': (context) =>
            ChangePassword(userId: userId, email: email),
      },
    );
  }
}
