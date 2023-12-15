import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_attempt/settings.dart';

class ChangePassword extends StatefulWidget {
  final String userId;
  final String email;

  const ChangePassword({Key? key, required this.userId, required this.email})
      : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
//   String currentPassword = '';

  String currentPassword = '';
  String newPassword = '';
  String confirmNewPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) {
                currentPassword = value;
              },
              decoration: InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                newPassword = value;
              },
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                confirmNewPassword = value;
              },
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _validateAndChangePassword();
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndChangePassword() {}
}
