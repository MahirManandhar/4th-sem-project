import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_attempt/admin/admin_bus.dart';

import 'package:first_attempt/admin/update_fee.dart';
import 'package:first_attempt/admin/admin_fee.dart';
import 'package:first_attempt/admin/admin_notice.dart';
import 'package:first_attempt/admin/update_details/update_details.dart';
import 'package:first_attempt/admin/update_notice.dart';
import 'package:first_attempt/calendar.dart';

import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  final String userId;
  final String email;
  const Admin({super.key, required this.userId, required this.email});

  // const Admin({super.key});

  @override
  State<Admin> createState() => _StudentState();
}

class _StudentState extends State<Admin> {
  int index = 0;
  final screen = [
    const AdmNotice(),
    const UpdateNotice(),
    const UpdateDetails(),
    const AdminBus(),
    const AdminFee(),
    const UpdateFee(),
  ];

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
                  icon: const Icon(Icons.calendar_month_outlined,color:Colors.white),
                  selectedIcon: const Icon(Icons.calendar_month,color:Colors.white),
                  
                ),
                actions: [
            Builder(
              builder: (context) => IconButton(
                    icon: Icon(Icons.more_vert_outlined,color: Colors.white),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
            ),
          ],
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
          backgroundColor: Colors.white,
          child: Column(children: [
            DrawerHeader(
                child: ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 150, height: 70),
                    child: const Image(
                        image: AssetImage('assets/images/logo.png')))),
            const ListTile(
              leading: Icon(Icons.info),
              title: Text("ABOUT US"),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("SETTINGS"),
              onTap: () => {
                Navigator.pop(context),
                Navigator.pushNamed(context, '/settings'),
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
                    icon: Icon(Icons.person_outline_outlined),
                    selectedIcon: Icon(Icons.person),
                    label: 'Update'),
                NavigationDestination(
                    icon: Icon(Icons.bus_alert_outlined),
                    selectedIcon: Icon(Icons.bus_alert),
                    label: 'Bus'),
                NavigationDestination(
                    icon: Icon(Icons.attach_money_outlined),
                    selectedIcon: Icon(Icons.attach_money),
                    label: 'Fee'),
              ]),
        ));
  }
}
