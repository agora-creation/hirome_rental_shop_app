import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hirome_rental_shop_app/models/shop_login.dart';

class ShopLoginService {
  String collection = 'shopLogin';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void create(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).set(values);
  }

  Future<ShopLoginModel?> select(String? id) async {
    ShopLoginModel? ret;
    await firestore
        .collection(collection)
        .doc(id ?? 'error')
        .get()
        .then((value) {
      ret = ShopLoginModel.fromSnapshot(value);
    });
    return ret;
  }
}
