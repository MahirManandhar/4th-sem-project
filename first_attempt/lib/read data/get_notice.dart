import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetNotice extends StatelessWidget {
  final String documentId;

  GetNotice({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference notices =
        FirebaseFirestore.instance.collection('Notices');
    return FutureBuilder<DocumentSnapshot>(
      future: notices.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                    'FROM: ${data['Name']}                                            ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 20,
                        color: Color.fromRGBO(41, 72, 53, 0.612))),
              ),
              SizedBox(height: 10),
              Text(' ${data['Notice']}',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 18,
                      color: Color.fromRGBO(6, 20, 11, 0.612))),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text('DATE: ${data['Date']}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 20,
                        color: Color.fromRGBO(41, 72, 53, 0.612))),
              ),
            ],
          ));
        }
        return Text('Loading...',
            style: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 20,
                color: Color.fromRGBO(94, 110, 100, 100)));
      }),
    );
  }
}
