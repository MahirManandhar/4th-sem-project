import 'package:first_attempt/admin/admin_bus.dart';
import 'package:first_attempt/admin/update_fee.dart';
import 'package:first_attempt/admin/admin_notice.dart';
import 'package:first_attempt/admin/update_details/update_details.dart';
import 'package:first_attempt/admin/update_notice.dart';
import 'package:first_attempt/calendar.dart';
import 'package:first_attempt/logout.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _StudentState();
}

class _StudentState extends State<Admin> {
  int index = 0;
  final screen = [
    const AdminNotice(),
    const UpdateNotice(),
    const UpdateDetails(),
    const AdminBus(),
    const UpdateFee()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calendar()));
            },
            icon: const Icon(Icons.calendar_month_outlined),
            selectedIcon: const Icon(Icons.calendar_month),
          ),
          title: const Center(child: Text('PATHSHALA')),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LogOut()));
              },
              icon: const Icon(Icons.more_vert_outlined),
              selectedIcon: const Icon(Icons.more_vert),
            )
          ],
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
