import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About Pathshala'),
              SizedBox(height: 20),
              Text(
                  'Developed strategically with Flutter for cross-platform compatibility and Firebase for a robust backend, the app ensures a seamless user experience on both iOS and Android devices. Key features encompass quick notifications, class updates, teacher contacts, an academic calendar, and fee updates, constituting a streamlined system for efficient communication.')
            ],
          )),
    );
  }
}
