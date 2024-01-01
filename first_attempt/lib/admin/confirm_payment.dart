import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({super.key});

  @override
  ConfirmPaymentState createState() => ConfirmPaymentState();
}

class ConfirmPaymentState extends State<ConfirmPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Payment Status',
            style: TextStyle(color: Colors.black54, fontSize: 20),
          ),
        ),
      ),
      body: const ClassList(),
    );
  }
}

class ClassList extends StatelessWidget {
  const ClassList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Students').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child:  CircularProgressIndicator());
        }

        var classes = snapshot.data!.docs;

        return ListView.builder(
          itemCount: classes.length,
          itemBuilder: (context, index) {
            var className = classes[index].id;
            return ClassTile(className: className);
          },
        );
      },
    );
  }
}

class ClassTile extends StatelessWidget {
  final String className;

  const ClassTile({super.key, required this.className});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(className),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StudentListPopup(className: className);
          },
        );
      },
    );
  }
}

class StudentListPopup extends StatelessWidget {
  final String className;

  const StudentListPopup({super.key, required this.className});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Class $className'),
      content: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Students')
            .doc(className)
            .collection('students')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          var students = snapshot.data!.docs;

          return Column(
            children: students.map((student) {
              var studentData = student.data() as Map<String, dynamic>;
              var studentName =
                  '${studentData['fn']} ${studentData['mn']} ${studentData['ln']}';
              var email = student.id;
              var paidAdmin = studentData['paid_admin'] ?? false;

              return StudentTile(
                studentName: studentName,
                email: email,
                className: className,
                paidAdmin: paidAdmin,
              );
            }).toList(),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class StudentTile extends StatefulWidget {
  final String studentName;
  final String email;
  final String className;
  final bool paidAdmin;

  const StudentTile({
    super.key,
    required this.studentName,
    required this.email,
    required this.className,
    required this.paidAdmin,
  });

  @override
  _StudentTileState createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  bool isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(widget.studentName),
          ),
          if (!isConfirmed && !widget.paidAdmin) // Show buttons only if not confirmed and paid_admin is false
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    // confiem or not
                    setState(() {
                      isConfirmed = true;
                    });

                    // Update db
                    FirebaseFirestore.instance
                        .collection('Fees')
                        .doc(widget.className)
                        .collection('Students')
                        .doc(widget.email)
                        .update({
                      'paid_admin': true,
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    // close
                    setState(() {
                      isConfirmed = false;
                    });

                    FirebaseFirestore.instance
                        .collection('Fees')
                        .doc(widget.className)
                        .collection('Students')
                        .doc(widget.email)
                        .update({
                      'paid_admin': false,
                    });
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
