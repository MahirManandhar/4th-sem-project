import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notices =
      FirebaseFirestore.instance.collection('Notices');

  Future<void> deleteNotice(String docID) {
    return notices.doc(docID).delete();
  }
}
