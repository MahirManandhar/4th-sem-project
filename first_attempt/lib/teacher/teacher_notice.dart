import 'package:flutter/material.dart';

class TeacherNotice extends StatelessWidget {
  const TeacherNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextFormField(
              maxLines: 50,
              keyboardType: TextInputType.multiline,
              
            )
          ],
        ),
      ),
    );
  }
}
