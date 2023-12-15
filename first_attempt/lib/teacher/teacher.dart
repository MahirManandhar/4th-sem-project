import 'package:first_attempt/calendar.dart';
import 'package:first_attempt/student/bus.dart';
import 'package:first_attempt/student/notice.dart';
import 'package:first_attempt/teacher/teacher_notice.dart';
import 'package:first_attempt/teacher/teacher_profile.dart';
import 'package:flutter/material.dart';

class Teacher extends StatefulWidget {
  final String userId;  
  final String email;
  const Teacher({Key? key, required this.userId, required this.email}) : super(key: key);
  // const Teacher({super.key});

  @override
  State<Teacher> createState() => _StudentState();
}

class _StudentState extends State<Teacher> {
  int index = 0;
  final screen = [
    const Notice(),
    const TeacherNotice(),
    const Bus(),
    const TeacherProfile()
  ];

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
                  icon: const Icon(Icons.calendar_month_outlined),
                  selectedIcon: const Icon(Icons.calendar_month),
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
          child: Column(children: [
            DrawerHeader(
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 150, height: 70),
                    child: Image(image: AssetImage('assets/images/logo.png')))),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("ABOUT US"),
              onTap: () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, '/aboutus'),
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title:const Text("SETTINGS"),
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
              onTap: () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, '/login'),
              },
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
                    icon: Icon(Icons.edit_note_outlined),
                    selectedIcon: Icon(Icons.edit_note),
                    label: 'Publish'),
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
