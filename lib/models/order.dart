//status
//0=受注待ち,1=受注完了,9=キャンセル

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
}
