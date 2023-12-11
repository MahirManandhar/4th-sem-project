import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(95.0),
        child: Container(
          color: const Color.fromRGBO(131, 151, 136, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: AppBar(
              backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
              title: Center(
                  child: ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 150, height: 70),
                      child:
                          Image(image: AssetImage('assets/images/logo.png')))),
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
                  constraints: BoxConstraints.tightFor(width: 150, height: 70),
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
            leading: Icon(Icons.settings),
            title: Text("SETTINGS"),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("LOGOUT"),
            onTap: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, '/login'),
            },
          ),
        ]),
      ),
    );
  }
}
