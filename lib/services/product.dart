import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hirome_rental_shop_app/models/product.dart';

class ProductService {
  String collection = 'product';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> selectList({
    required String number,
    required String name,
    required String invoiceNumber,
  }) async {
    List<ProductModel> ret = [];
    String? isEqualToNumber;
    String? isEqualToName;
    String? isEqualToInvoiceNumber;
    if (number != '') {
      isEqualToNumber = number;
    }
    if (name != '') {
      isEqualToName = name;
    }
    if (invoiceNumber != '') {
      isEqualToInvoiceNumber = invoiceNumber;
    }
    await firestore
        .collection(collection)
        .where('number', isEqualTo: isEqualToNumber)
        .where('name', isEqualTo: isEqualToName)
        .where('invoiceNumber', isEqualTo: isEqualToInvoiceNumber)
        .orderBy('priority', descending: false)
        .get()
        .then((value) {
      for (DocumentSnapshot<Map<String, dynamic>> map in value.docs) {
        ret.add(ProductModel.fromSnapshot(map));
      }
    });
    return ret;
  }
}
