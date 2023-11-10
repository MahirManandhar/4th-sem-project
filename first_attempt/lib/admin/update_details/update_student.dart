import 'package:flutter/material.dart';

class UpdateStudent extends StatelessWidget {
  const UpdateStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 65),
          child: Text('PATHSHALA'),
        ),
      ),
    );
  }
}
