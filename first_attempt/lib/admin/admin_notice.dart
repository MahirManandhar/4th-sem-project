import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/read%20data/get_notice.dart';
import 'package:first_attempt/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class AdmNotice extends StatefulWidget {
  const AdmNotice({super.key});

  @override
  State<AdmNotice> createState() => _AdmNoticeState();
}

class _AdmNoticeState extends State<AdmNotice> {
  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 0));
  }

  final FirestoreService firestoreService = FirestoreService();
  final user = FirebaseAuth.instance.currentUser;

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Notices')
        .orderBy('Timestamp', descending: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: Color.fromRGBO(131, 151, 136, 1),
        height: 200,
        backgroundColor: Colors.white,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        child: Center(
          child: Column(
            children: [
              Text('NOTICES',
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
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Color.fromRGBO(217, 217, 217, 100),
                                ),
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: ((context) {
                                          firestoreService
                                              .deleteNotice(docIDs[index]);
                                        }),
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: GetNotice(documentId: docIDs[index]),
                                  ),
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
