//status
//0=受注待ち,1=受注完了,9=キャンセル

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hirome_rental_shop_app/models/cart.dart';

class OrderModel {
  String _id = '';
  String _number = '';
  String _shopId = '';
  String _shopNumber = '';
  String _shopName = '';
  String _shopInvoiceName = '';
  List<CartModel> carts = [];
  int _status = 0;
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get number => _number;
  String get shopId => _shopId;
  String get shopNumber => _shopNumber;
  String get shopName => _shopName;
  String get shopInvoiceName => _shopInvoiceName;
  int get status => _status;
  DateTime get createdAt => _createdAt;

  OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> map = snapshot.data() ?? {};
    _id = map['id'] ?? '';
    _number = map['number'] ?? '';
    _shopId = map['shopId'] ?? '';
    _shopNumber = map['shopNumber'] ?? '';
    _shopName = map['shopName'] ?? '';
    _shopInvoiceName = map['shopInvoiceName'] ?? '';
    carts = _convertCarts(map['carts']);
    _status = map['invoiceName'] ?? 0;
    _createdAt = map['createdAt'].toDate() ?? DateTime.now();
  }

  List<CartModel> _convertCarts(List carts) {
    List<CartModel> ret = [];
    for (Map map in carts) {
      ret.add(CartModel.fromMap(map));
    }
    return ret;
  }

  String getProducts() {
    String ret = '';
    for (CartModel cart in carts) {
      if (ret != '') ret += ',';
      ret += cart.name;
    }
    return ret;
  }

  String getStatus() {
    String ret = '';
    switch (status) {
      case 0:
        ret = '受注待ち';
        break;
      case 1:
        ret = '受注完了';
        break;
      case 9:
        ret = 'キャンセル';
        break;
    }
    return ret;
  }
}
