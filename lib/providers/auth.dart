import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/models/cart.dart';
import 'package:hirome_rental_shop_app/models/product.dart';
import 'package:hirome_rental_shop_app/models/shop.dart';
import 'package:hirome_rental_shop_app/models/shop_login.dart';
import 'package:hirome_rental_shop_app/services/cart.dart';
import 'package:hirome_rental_shop_app/services/shop.dart';
import 'package:hirome_rental_shop_app/services/shop_login.dart';

enum AuthStatus {
  authenticated,
  uninitialized,
  authenticating,
  unauthenticated,
}

class AuthProvider with ChangeNotifier {
  AuthStatus _status = AuthStatus.uninitialized;
  AuthStatus get status => _status;
  FirebaseAuth? auth;
  User? _authUser;
  CartService cartService = CartService();
  ShopService shopService = ShopService();
  ShopLoginService shopLoginService = ShopLoginService();
  ShopModel? _shop;
  ShopLoginModel? _shopLogin;
  List<CartModel> _carts = [];
  ShopModel? get shop => _shop;
  ShopLoginModel? get shopLogin => _shopLogin;
  List<CartModel> get carts => _carts;

  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();

  void clearController() {
    number.clear();
    password.clear();
  }

  AuthProvider.initialize() : auth = FirebaseAuth.instance {
    auth?.authStateChanges().listen(_onStateChanged);
  }

  Future<String?> signIn() async {
    String? error;
    try {
      _status = AuthStatus.authenticating;
      notifyListeners();
      await auth?.signInAnonymously().then((value) async {
        ShopModel? tmpShop = await shopService.select(
          number: number.text,
          password: password.text,
        );
        if (tmpShop != null) {
          _shop = tmpShop;
          shopLoginService.create({
            'id': value.user?.uid,
            'shopNumber': tmpShop.number,
            'shopName': tmpShop.name,
            'deviceName': '',
            'accept': false,
            'createdAt': DateTime.now(),
          });
          await setPrefsString('shopNumber', tmpShop.number);
          await setPrefsString('shopPassword', tmpShop.password);
        } else {
          await auth?.signOut();
          error = 'ログインに失敗しました';
        }
      });
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      error = 'ログインに失敗しました';
    }
    return error;
  }

  Future<String?> updatePassword(String newPassword) async {
    String? error;
    try {
      shopService.update({
        'id': shop?.id,
        'password': newPassword,
      });
    } catch (e) {
      error = 'パスワード変更に失敗しました';
    }
    return error;
  }

  Future<String?> updateFavorites(List<String> favorites) async {
    String? error;
    try {
      shopService.update({
        'id': shop?.id,
        'favorites': favorites,
      });
    } catch (e) {
      error = 'お気に入り設定に失敗しました';
    }
    return error;
  }

  Future signOut() async {
    await auth?.signOut();
    _status = AuthStatus.unauthenticated;
    await allRemovePrefs();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future _onStateChanged(User? authUser) async {
    if (authUser == null) {
      _status = AuthStatus.unauthenticated;
    } else {
      _authUser = authUser;
      String? tmpShopNumber = await getPrefsString('shopNumber');
      String? tmpShopPassword = await getPrefsString('shopPassword');
      ShopModel? tmpShop = await shopService.select(
        number: tmpShopNumber,
        password: tmpShopPassword,
      );
      if (tmpShop == null) {
        _status = AuthStatus.unauthenticated;
      } else {
        _shop = tmpShop;
        _shopLogin = await shopLoginService.select(_authUser?.uid);
        await initCarts();
        _status = AuthStatus.authenticated;
      }
    }
    notifyListeners();
  }

  Future initCarts() async {
    _carts = await cartService.get();
    notifyListeners();
  }

  Future addCarts(ProductModel product, int requestQuantity) async {
    await cartService.add(product, requestQuantity);
  }

  Future removeCart(CartModel cart) async {
    await cartService.remove(cart);
  }

  Future clearCart() async {
    await cartService.clear();
  }
}
