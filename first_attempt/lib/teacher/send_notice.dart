import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_attempt/read%20data/get_notice.dart';
import 'package:flutter/material.dart';
import 'package:first_attempt/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class SendNotice extends StatefulWidget {
  final String email;
  final String userId;

  const SendNotice({super.key, required this.email, required this.userId});

  @override
  State<SendNotice> createState() => _SendNoticeState();
}

class _SendNoticeState extends State<SendNotice> {
  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 2));
  }

  final FirestoreService firestoreService = FirestoreService();
  final user = FirebaseAuth.instance.currentUser;

  List<String> docIDs = [];

  Future<String> getName(String email) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection('Teachers')
        .doc(email)
        .get();

    if (doc.exists) {
      String firstName = doc.data()!['Name First']; //['First'];
      String midName = doc.data()!['Name Middle'];
      String lastName = doc.data()!['Name Last'];
      String name = '$firstName $midName $lastName';
      return name;
    } else {
      return '';
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getDocId() async* {
    String name2 = await getName(widget.email);
    yield* FirebaseFirestore.instance
        .collection('Notices')
        .where('Name', isEqualTo: name2)
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

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No notices sent yet.',
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
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color:
                                      const Color.fromRGBO(217, 217, 217, 100),
                                ),
                                child: Slidable(
                                  key: ValueKey(snapshot.data!.docs[index].id),
                                  endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: ((context) {
                                          firestoreService.deleteNotice(
                                              snapshot.data!.docs[index].id);
                                        }),
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: GetNotice(
                                        documentId:
                                            snapshot.data!.docs[index].id),
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
