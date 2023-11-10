import 'package:flutter/material.dart';

class AdminNotice extends StatelessWidget {
  const AdminNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Notices'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
    );
  }
}
