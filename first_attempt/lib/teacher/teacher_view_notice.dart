import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/read%20data/get_notice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TechNotice extends StatefulWidget {
  const TechNotice({super.key});

  @override
  State<TechNotice> createState() => _TechNoticeState();
}

class _TechNoticeState extends State<TechNotice> {
  final user = FirebaseAuth.instance.currentUser;

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Notices')
        .where('Class', whereIn: ['All', 'Teacher', '1'])
        // .orderBy('Timestamp', descending: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
    //         await FirebaseFirestore.instance
    // .collection('Notices')
    // .where('Name', isEqualTo: 'TEACHER')
    // .orderBy('Timestamp', descending: true)
    // .get()
    // .then((snapshot) => snapshot.docs.forEach((document) {
    //       print(document.reference);
    //       docIDs.add(document.reference.id);
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('NOTICES',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(94, 110, 100, 100),
                    fontFamily: 'Arima',
                    fontSize: 45)),
            Expanded(
              child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: const Color.fromRGBO(217, 217, 217, 100),
                              ),
                              child: ListTile(
                                title: GetNotice(documentId: docIDs[index]),
                              ),
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
