import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("SETTINGS"),
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
    );
  }
}
