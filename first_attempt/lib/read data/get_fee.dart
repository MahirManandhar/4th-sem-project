// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class GetFee extends StatelessWidget {
//   final String name;
//   final String documentId;

//   const GetFee({super.key, required this.documentId, required this.name});

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference notices =
//         FirebaseFirestore.instance.collection('Notices');
//     return FutureBuilder<DocumentSnapshot>(
//       future: notices.doc(documentId).get(),
//       builder: ((context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           // return Container(
//           //     child: Column(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: [
//           //     Align(
//           //       alignment: Alignment.centerRight,
//           //       child: Text(
//           //           'FROM: ${data['Name']}                                            ',
//           //           textAlign: TextAlign.left,
//           //           style: const TextStyle(
//           //               fontFamily: 'FiraSans',
//           //               fontSize: 20,
//           //               color: Color.fromRGBO(41, 72, 53, 0.612))),
//           //     ),
//           //     const SizedBox(height: 10),
//           //     Text(' ${data['Notice']}',
//           //         textAlign: TextAlign.justify,
//           //         style: const TextStyle(
//           //             fontFamily: 'Quicksand',
//           //             fontSize: 18,
//           //             color: Color.fromRGBO(6, 20, 11, 0.612))),
//           //     const SizedBox(height: 10),
//           //     Align(
//           //       alignment: Alignment.centerRight,
//           //       child: Text('DATE: ${data['Date']}',
//           //           textAlign: TextAlign.right,
//           //           style: const TextStyle(
//           //               fontFamily: 'FiraSans',
//           //               fontSize: 20,
//           //               color: Color.fromRGBO(41, 72, 53, 0.612))),
//           //     ),
//           //   ],
//           // ));


// return Scaffold(
//               // appBar: AppBar(
//               //   title: Text('Fee Details for $studentName'),
//               // ),
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
//                       '${remainingDays > 0 ? remainingDays : 'Expired'} days remaining',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               bottomNavigationBar: BottomAppBar(
//                 child: ElevatedButton(
//                   onPressed: (isPaidStudent && isPaidAdmin)
//                       ? null // Button disabled if both are true
//                       : () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text('Request Admin Confirmation'),
//                                 content: const Text(
//                                   'Request the admin to confirm the payment?',
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: const Text('Cancel'),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       FirebaseFirestore.instance
//                                           .collection('Fees')
//                                           .doc(studentClass)
//                                           .collection('Students')
//                                           .doc(widget.email)
//                                           .update({
//                                         'paid_student': true,
//                                       }).then((_) {
//                                         Navigator.of(context).pop();
//                                         setState(() {}); //ui update
//                                       });
//                                     },
//                                     child: const Text('Request'),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                   child: Text(
//                     paymentStatus,
//                     style: const TextStyle(
//                       color: Color.fromARGB(255, 18, 18, 18),
//                     ),
//                   ),
//                 ),
//               ),
//             );







//         }
//         return const Text('Loading...',
//             style: TextStyle(
//                 fontFamily: 'FiraSans',
//                 fontSize: 20,
//                 color: Color.fromRGBO(94, 110, 100, 100)));
//       }),
//     );
//   }
// }
