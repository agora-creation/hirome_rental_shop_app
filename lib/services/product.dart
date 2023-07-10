import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  String collection = 'product';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamList() {
    return FirebaseFirestore.instance
        .collection(collection)
        .where('display', isEqualTo: true)
        .orderBy('priority', descending: false)
        .snapshots();
  }
}
