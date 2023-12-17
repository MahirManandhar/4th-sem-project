import 'package:flutter/material.dart';
import 'package:first_attempt/admin/confirm_payment.dart';
import 'package:first_attempt/admin/update_fee.dart';

class AdminFee extends StatefulWidget {
  const AdminFee({super.key});

  @override
  AdminFeeState createState() => AdminFeeState();
}

class AdminFeeState extends State<AdminFee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('vbghbdsknndjhvbdcknjhbjk'),
      // ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ListTile(
              title: const Text('Update Class Fees'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdateFee()),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Confirm Student\'s Payment'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConfirmPayment()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateClassFeesScreen extends StatelessWidget {
  const UpdateClassFeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Class Fees'),
      ),
      body: const Center(
        child: Text('This screen allows you to update class fees.'),
      ),
    );
  }
}

class ConfirmStudentPaymentScreen extends StatelessWidget {
  const ConfirmStudentPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Student\'s Payment'),
      ),
      body: const Center(
        child: Text('This screen allows you to confirm a student\'s payment.'),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AdminFee(),
  ));
}
