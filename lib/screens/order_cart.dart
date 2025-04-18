import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/models/shop_login.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';
import 'package:hirome_rental_shop_app/providers/order.dart';
import 'package:hirome_rental_shop_app/services/shop_login.dart';
import 'package:hirome_rental_shop_app/widgets/cart_list.dart';
import 'package:hirome_rental_shop_app/widgets/custom_lg_button.dart';
import 'package:hirome_rental_shop_app/widgets/link_text.dart';
import 'package:provider/provider.dart';

class OrderCartScreen extends StatefulWidget {
  const OrderCartScreen({super.key});

  @override
  State<OrderCartScreen> createState() => _OrderCartScreenState();
}

class _OrderCartScreenState extends State<OrderCartScreen> {
  ShopLoginService shopLoginService = ShopLoginService();
  bool buttonDisabled = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
        title: Text(
          '${authProvider.shop?.name} : 注文確認',
          style: const TextStyle(color: kBlackColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: kBlackColor),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '注文の内容を確認してください\n間違いなければ『注文する』ボタンを押してください',
                style: TextStyle(
                  color: kRedColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              const Text('注文する商品'),
              const Divider(height: 1, color: kGreyColor),
              Column(
                children: authProvider.carts.map((cart) {
                  return CartList(cart: cart);
                }).toList(),
              ),
              const SizedBox(height: 16),
              buttonDisabled
                  ? const CustomLgButton(
                      label: '注文する',
                      labelColor: kWhiteColor,
                      backgroundColor: kGreyColor,
                      onPressed: null,
                    )
                  : CustomLgButton(
                      label: '注文する',
                      labelColor: kWhiteColor,
                      backgroundColor: kBlueColor,
                      onPressed: () async {
                        setState(() {
                          buttonDisabled = true;
                        });
                        String createdUserName = '';
                        ShopLoginModel? shopLogin =
                            await shopLoginService.select(
                          id: authProvider.authUser?.uid,
                        );
                        if (shopLogin != null) {
                          createdUserName = shopLogin.requestName;
                        }
                        String? error = await orderProvider.create(
                          shop: authProvider.shop,
                          carts: authProvider.carts,
                          createdUserName: createdUserName,
                        );
                        if (error != null) {
                          if (!mounted) return;
                          showMessage(context, error, false);
                          setState(() {
                            buttonDisabled = false;
                          });
                          return;
                        }
                        await authProvider.clearCart();
                        await authProvider.initCarts();
                        if (!mounted) return;
                        showMessage(context, '注文に成功しました', true);
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    ),
              const SizedBox(height: 24),
              Center(
                child: LinkText(
                  label: 'カートを空にする',
                  labelColor: kRedColor,
                  onTap: () async {
                    await authProvider.clearCart();
                    await authProvider.initCarts();
                    if (!mounted) return;
                    showMessage(context, 'カートを空にしました', true);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
