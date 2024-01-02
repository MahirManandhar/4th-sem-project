// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/read%20data/get_notice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Notice extends StatefulWidget {
  final String email;
  final String userId;

  const Notice({super.key, required this.email, required this.userId});

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 2));
  }

  final user = FirebaseAuth.instance.currentUser;

  List<String> docIDs = [];

  Future<String> getClass(String email) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection('Students')
        .doc(email)
        .get();

    if (doc.exists) {
      String className = doc.data()!['Class'];
      print(className);
      return className;
    } else {
      return '';
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getDocId() async* {
    String className = await getClass(widget.email);
    yield* FirebaseFirestore.instance
        .collection('Notices')
        .where('Class', whereIn: [className, 'All'])
        .orderBy('Timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: const Color.fromRGBO(131, 151, 136, 1),
        height: 200,
        backgroundColor: Colors.white,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        child: Center(
          child: Column(
            children: [
              const Text('NOTICES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(94, 110, 100, 100),
                      fontFamily: 'Arima',
                      fontSize: 45)),
              Expanded(
                child: StreamBuilder(
                    stream: getDocId(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

// if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Text('User not found');
//         }

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No notices received',
                            style: TextStyle(
                              fontFamily: 'Arima',
                              fontSize: 40,
                              color: Color.fromRGBO(53, 79, 63, 100),
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color:
                                      const Color.fromRGBO(217, 217, 217, 100),
                                ),
                                child: ListTile(
                                  title: GetNotice(
                                      documentId:
                                          snapshot.data!.docs[index].id),
                                ),
                              ),
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
