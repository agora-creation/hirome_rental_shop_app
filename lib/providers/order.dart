import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/models/cart.dart';
import 'package:hirome_rental_shop_app/models/center.dart';
import 'package:hirome_rental_shop_app/models/order.dart';
import 'package:hirome_rental_shop_app/models/shop.dart';
import 'package:hirome_rental_shop_app/services/center.dart';
import 'package:hirome_rental_shop_app/services/messaging.dart';
import 'package:hirome_rental_shop_app/services/order.dart';

class OrderProvider with ChangeNotifier {
  CenterService centerService = CenterService();
  MessagingService messagingService = MessagingService();
  OrderService orderService = OrderService();

  DateTime searchStart = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );
  DateTime searchEnd = DateTime(
    DateTime.now().year,
    DateTime.now().month + 1,
    1,
  ).add(const Duration(days: -1));

  void searchChange(DateTime start, DateTime end) {
    searchStart = start;
    searchEnd = end;
    notifyListeners();
  }

  Future<String?> create({
    ShopModel? shop,
    List<CartModel>? carts,
    String createdUserName = '',
  }) async {
    String? error;
    if (shop == null) return '注文に失敗しました';
    if (carts == null) return '注文に失敗しました';
    if (carts.isEmpty) return '注文に失敗しました';
    try {
      String id = orderService.id();
      String dateTime = dateText('yyyyMMddHHmmss', DateTime.now());
      String number = '${shop.number}-$dateTime';
      List<Map> newCarts = [];
      for (CartModel cart in carts) {
        newCarts.add(cart.toMap());
      }
      orderService.create({
        'id': id,
        'number': number,
        'shopId': shop.id,
        'shopNumber': shop.number,
        'shopName': shop.name,
        'shopInvoiceName': shop.invoiceName,
        'carts': newCarts,
        'status': 0,
        'createdUserName': createdUserName,
        'updatedUserName': createdUserName,
        'updatedAt': DateTime.now(),
        'createdAt': DateTime.now(),
      });
      List<CenterModel> centers = await centerService.selectList();
      for (CenterModel center in centers) {
        messagingService.fcmSend(center.token);
      }
    } catch (e) {
      error = '注文に失敗しました';
    }
    return error;
  }

  Future<String?> reCreate(OrderModel order) async {
    String? error;
    try {
      String id = orderService.id();
      String dateTime = dateText('yyyyMMddHHmmss', DateTime.now());
      String number = '${order.shopNumber}-$dateTime';
      List<Map> newCarts = [];
      for (CartModel cart in order.carts) {
        newCarts.add(cart.toMap());
      }
      orderService.create({
        'id': id,
        'number': number,
        'shopId': order.shopId,
        'shopNumber': order.shopNumber,
        'shopName': order.shopName,
        'shopInvoiceName': order.shopInvoiceName,
        'carts': newCarts,
        'status': 0,
        'createdUserName': order.createdUserName,
        'updatedUserName': order.createdUserName,
        'updatedAt': DateTime.now(),
        'createdAt': DateTime.now(),
      });
      List<CenterModel> centers = await centerService.selectList();
      for (CenterModel center in centers) {
        messagingService.fcmSend(center.token);
      }
    } catch (e) {
      error = '再注文に失敗しました';
    }
    return error;
  }

  Future<String?> cancel(OrderModel order) async {
    String? error;
    try {
      orderService.update({
        'id': order.id,
        'status': 9,
        'updatedUserName': order.createdUserName,
        'updatedAt': DateTime.now(),
      });
    } catch (e) {
      error = 'キャンセルに失敗しました';
    }
    return error;
  }
}
