// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class Fee extends StatelessWidget {
//   final String userId;
//   final String email;

//   const Fee({Key? key, required this.userId, required this.email}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('Students').doc(email).get(),
//       builder: (context, snapshot) {
//       print('email');
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }

//         if (!snapshot.hasData || !snapshot.data!.exists) {
//           return const Text('User not found');
//         }
//         print('user founddddddddddd');
//         var studentData = snapshot.data!.data() as Map<String, dynamic>?;

// if (studentData == null || !studentData.containsKey('Name.First')) {
//           print('Student data: $studentData');
//           print('Name not found');
//           return const Text('Nname not found for the user');
//         }

// String studentName   = studentData['Name.First'];
//         print('Student name: $studentName');

//         if (studentData == null || !studentData.containsKey('class')) {
//           print('Student data: $studentData');
//           print('Class not found');
//           return const Text('Class information not found for the user');
//         }

//         String studentClass = studentData['class'];
//         print('Student Class: $studentClass');

//         return FutureBuilder<DocumentSnapshot>(
//           future: FirebaseFirestore.instance.collection('Fees').doc(studentClass).get(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               print('Fees data found for the class');
//               return const CircularProgressIndicator();
//             }

//             if (!snapshot.hasData || !snapshot.data!.exists) {
//               print('Fees data not found for the class');
//               return const Text('Fees data not found for the class');
//             }

//             var feesData = snapshot.data!.data() as Map<String, dynamic>?;
//             if (feesData == null ||
//                 !feesData.containsKey('exam fees') ||
//                 !feesData.containsKey('tuition fees') ||
//                 !feesData.containsKey('eca fees')) {
//               return const Text('Incomplete fees data for the class');
//             }

//             String examFee = feesData['exam fees'].toString();
//             String tuitionFee = feesData['tuition fees'].toString();
//             String ecaFee = feesData['eca fees'].toString();
//             String totalFee = (int.parse(examFee) + int.parse(tuitionFee) + int.parse(ecaFee)).toString();
//             DateTime deadline = DateTime(2024, 01, 30);
//             DateTime currentDate = DateTime.now();
//             int remainingDays = deadline.difference(currentDate).inDays;

//             return Scaffold(
//               appBar: AppBar(
//                 title:  Text('Fee Details for $studentName'),
//               ),
//               body: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Your Bill:',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 'Exam Fee:',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Rs. $examFee',
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 'Tuition Fee:',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Rs. $tuitionFee',
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 'ECA Fee:',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Rs. $ecaFee',
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 'Total:',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Rs. $totalFee',
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Deadline: ${DateFormat('dd MMMM yyyy').format(deadline)}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       'Remaining Days: ${remainingDays > 0 ? remainingDays : 'Expired'}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Fee extends StatefulWidget {
  final String email;
  final String userId;

  const Fee({Key? key, required this.email, required this.userId})
      : super(key: key);

  @override
  _FeeState createState() => _FeeState();
}

class _FeeState extends State<Fee> {
  Future<Map<String, dynamic>> searchEmailInStudents(String email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Students').get();

    for (var document in snapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> studentsCollection = await document
          .reference
          .collection('students')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (studentsCollection.docs.isNotEmpty) {
        return studentsCollection.docs.first.data() ?? {};
      }
    }

    return {};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: searchEmailInStudents(widget.email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('User not found');
        }

        var studentData = snapshot.data!;

        if (!studentData.containsKey('fn')) {
          print('Name not found for the user: ${widget.email}');
          return const Text('Name not found for the user');
        }

        String studentName = studentData['fn'];
        print('$studentName');

        if (!studentData.containsKey('class')) {
          print('Class information not found for the user: ${widget.email}');
          return const Text('Class information not found for the user');
        }

        String studentClass = studentData['class'];
        print('$studentClass');

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('Fees')
              .doc(studentClass)
              .collection('Students')
              .doc(widget.email)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('Fees data not found for the class');
            }

            var feesData = snapshot.data!.data() as Map<String, dynamic>;
            if (feesData == null ||
                !feesData.containsKey('exam fees') ||
                !feesData.containsKey('tuition fees') ||
                !feesData.containsKey('total eca fees') ||
                !feesData.containsKey('deadline')) {
              return const Text('Incomplete fees data for the class');
            }

            String examFee = feesData['exam fees'].toString();
            String tuitionFee = feesData['tuition fees'].toString();
            String ecaFee = feesData['total eca fees'].toString();
            String totalFee =
                (int.parse(examFee) + int.parse(tuitionFee) + int.parse(ecaFee))
                    .toString();
            // DateTime deadline = feesData['deadline'].toString();
            String deadlineString = feesData['deadline'].toString();
            DateTime deadline = DateTime.parse(deadlineString);

            DateTime currentDate = DateTime.now();
            int remainingDays = deadline.difference(currentDate).inDays;

            bool isPaidStudent = feesData['paid_student'] ?? false;

            bool isPaidAdmin = feesData['paid_admin'] ?? false;

            // Determine the payment status
            String paymentStatus = (isPaidStudent && isPaidAdmin)
                ? 'Payment Confirmed'
                : (isPaidStudent ? 'Requested' : 'Paid');

            return Scaffold(
              appBar: AppBar(
                title: Text('Fee Details for $studentName'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Bill:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Exam Fee:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rs. $examFee',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tuition Fee:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rs. $tuitionFee',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'ECA Fee:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rs. $ecaFee',
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rs. $totalFee',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Deadline: ${DateFormat('dd MMMM yyyy').format(deadline)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${remainingDays > 0 ? remainingDays : 'Expired'} days remaining',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: ElevatedButton(
                  onPressed: (isPaidStudent && isPaidAdmin)
                      ? null // Button disabled if both are true
                      : () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Request Admin Confirmation'),
                                content: Text(
                                  'Request the admin to confirm the payment?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('Fees')
                                          .doc(studentClass)
                                          .collection('Students')
                                          .doc(widget.email)
                                          .update({
                                        'paid_student': true,
                                      }).then((_) {
                                        Navigator.of(context).pop();
                                        setState(() {}); //ui update
                                      });
                                    },
                                    child: Text('Request'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                  child: Text(
                    paymentStatus,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 18, 18, 18),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
