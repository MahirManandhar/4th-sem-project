import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_attempt/calendar.dart';
//import 'package:first_attempt/logout.dart';
import 'package:first_attempt/student/bus.dart';
import 'package:first_attempt/student/fee.dart';
import 'package:first_attempt/student/notice.dart';
import 'package:first_attempt/student/profile.dart';
import 'package:flutter/material.dart';

class Student extends StatefulWidget {
  final String userId;
  final String email;
  const Student({super.key, required this.userId, required this.email});
  // const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  int index = 0;
  late List<Widget> screen;

  @override
  void initState() {
    super.initState();
    // auth = FirebaseAuth.instance;
    screen = [
      Notice(userId: widget.userId, email: widget.email),
      Fee(userId: widget.userId, email: widget.email),
      const Bus(),
      const Profile(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(95.0),
          child: Container(
            color: const Color.fromRGBO(131, 151, 136, 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: AppBar(
                backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Calendar()));
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                  selectedIcon: const Icon(Icons.calendar_month),
                ),
                title: Center(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                            width: 150, height: 70),
                        child: const Image(
                            image: AssetImage('assets/images/logo.png')))),
                // actions: [
                //   IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => const LogOut()));
                //     },
                //     icon: const Icon(Icons.more_vert_outlined),
                //     selectedIcon: const Icon(Icons.more_vert),
                //   )
                // ],
              ),
            ),
          ),
        ),
        endDrawer: Drawer(
          child: Column(children: [
            DrawerHeader(
                child: ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 150, height: 70),
                    child: const Image(
                        image: AssetImage('assets/images/logo.png')))),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("ABOUT US"),
              onTap: () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, '/aboutus'),
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("SETTINGS"),
              onTap: () => {
                Navigator.pop(context),
                // Navigator.pushNamed(context, '/settings', arguments: {'userId': userId, 'email': email})
                Navigator.pushNamed(
                  context,
                  '/settings',
                  arguments: {'userId': widget.userId, 'email': widget.email},
                )
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("LOGOUT"),
              onTap: () => _showLogoutConfirmationDialog(context),
            ),
          ]),
        ),
        body: screen[index],
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
              indicatorColor: Color.fromRGBO(131, 151, 136, 1)),
          child: NavigationBar(
              backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              animationDuration: const Duration(seconds: 1),
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.attach_money_outlined),
                    selectedIcon: Icon(Icons.attach_money),
                    label: 'Fee'),
                NavigationDestination(
                    icon: Icon(Icons.bus_alert_outlined),
                    selectedIcon: Icon(Icons.bus_alert),
                    label: 'Bus'),
                NavigationDestination(
                    icon: Icon(Icons.person_outline_outlined),
                    selectedIcon: Icon(Icons.person),
                    label: 'Profile'),
              ]),
        ));
  }
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Are you sure you want to logout?"),
        // title: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              _logoutAndNavigateToLogin(context);
            },
            child: const Text("Yes"),
            // child: const Text("Yes"),
          ),
        ],
      );
    },
  );
}

void _logoutAndNavigateToLogin(BuildContext context) async {
  try {
    // Navigate to the login screen
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context); // Close the confirmation dialog
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  } catch (e) {
    // Handle any errors that may occur during logout
    print("Error during logout: $e");
  }
}


  // Future<void> _logoutAndNavigateToLogin(BuildContext context) async {
  //   try {
  //     // Perform logout actions (e.g., delete tokens, clear session)
  //     // await _clearSession();

  //     // Navigate to the login screen
  //     Navigator.pop(context); // Close the confirmation dialog
  //     Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  //   } catch (e) {
  //     // Handle any errors that may occur during logout
  //     print("Error during logout: $e");
  //     // Optionally show an error message or take appropriate action
  //   }
  // }


  // Future<void> _clearSession() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // Clear user-related information from shared preferences
  //   prefs.remove('user_id');
  //   prefs.remove('user_email');
  //   // Remove other stored session information

  //   // Example: Clear the flag indicating that the user is logged in
  //   prefs.remove('is_logged_in');
  // }


// Future<void> _deleteUserTokens() async {

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.remove('user_token');
// }
