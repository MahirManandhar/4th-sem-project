import 'package:first_attempt/calendar.dart';
import 'package:first_attempt/student/bus.dart';
import 'package:first_attempt/teacher/teacher_view_notice.dart';
import 'package:first_attempt/teacher/teacher_notice.dart';
import 'package:first_attempt/teacher/teacher_profile.dart';
import 'package:first_attempt/teacher/send_notice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Teacher extends StatefulWidget {
  final String userId;
  final String email;
  const Teacher({super.key, required this.userId, required this.email});
  // const Teacher({super.key});

  @override
  State<Teacher> createState() => _StudentState();
}

class _StudentState extends State<Teacher> {
  int index = 0;
  late List<Widget> screen;

  @override
  void initState() {
    super.initState();
    // auth = FirebaseAuth.instance;
    screen = [
      const TechNotice(),
      SendNotice(userId: widget.userId, email: widget.email),
      TeacherNotice(userId: widget.userId, email: widget.email),
      const Bus(),
      const TeacherProfile()
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
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: AppBar(
              backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Calendar()));
                },
                icon: const Icon(Icons.calendar_month_outlined,
                    color: Colors.white),
                selectedIcon:
                    const Icon(Icons.calendar_month, color: Colors.white),
              ),
              title: Center(
                  child: ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(width: 150, height: 70),
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
       
        backgroundColor: Colors.white,
        child: Column(children: [
          DrawerHeader(
              child: ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 150, height: 70),
                  child: const Image(
                      image: AssetImage('assets/images/logo.png')))),
          ListTile(
            leading: const Icon(
              Icons.info,
            ),
            title: const Text("ABOUT US"),
            onTap: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, '/aboutus'),
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text("SETTINGS"),
            onTap: () => {
              Navigator.pop(context),
              // Navigator.pushNamed(context, '/settings'),
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
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
          ),
        ]),
      ),
      body: screen[index],
      bottomNavigationBar: Container(
        height: 90,
        color: const Color.fromRGBO(131, 151, 136, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            color: Colors.white,
            gap: 2,
            activeColor: const Color.fromRGBO(131, 151, 136, 1),
            iconSize: 23,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey.shade300,
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: 'HOME',
                textStyle: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Quicksand',
                  color: Color.fromRGBO(131, 151, 136, 1),
                ), // Change the label color
              ),
              GButton(
                icon: Icons.add_to_home_screen_outlined,
                text: 'SENT',
                textStyle: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Quicksand',
                  color: Color.fromRGBO(131, 151, 136, 1),
                ), // Change the label color
              ),
              GButton(
                icon: Icons.edit_note_outlined,
                text: 'PUBLISH',
                textStyle: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Quicksand',
                  color: Color.fromRGBO(131, 151, 136, 1),
                ), // Change the label color
              ),
              GButton(
                icon: Icons.bus_alert_outlined,
                text: 'BUS',
                textStyle: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Quicksand',
                  color: Color.fromRGBO(131, 151, 136, 1),
                ), // Change the label color
              ),
              GButton(
                icon: Icons.person_outline_outlined,
                text: 'PROFILE',
                textStyle: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Quicksand',
                  color: Color.fromRGBO(131, 151, 136, 1),
                ), // Change the label color
              ),
            ],
            selectedIndex: index,
            onTabChange: (index) => setState(() => this.index = index),
          ),
        ),
      ),
    );
  }
}
