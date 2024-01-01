import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetNotice extends StatelessWidget {
  final String documentId;

  const GetNotice({super.key, required this.documentId});

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
                    style: const TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 20,
                        color: Color.fromRGBO(41, 72, 53, 0.612))),
              ),
              const SizedBox(height: 10),
              Text(' ${data['Notice']}',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 18,
                      color: Color.fromRGBO(6, 20, 11, 0.612))),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text('DATE: ${data['Date']}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 20,
                        color: Color.fromRGBO(41, 72, 53, 0.612))),
              ),
            ],
          ));
        }
        return const Text('Loading...',
            style: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 20,
                color: Color.fromRGBO(94, 110, 100, 100)));
      }),
    );
  }
}
