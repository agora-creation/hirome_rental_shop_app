import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/models/shop_login.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';
import 'package:hirome_rental_shop_app/screens/history.dart';
import 'package:hirome_rental_shop_app/screens/login.dart';
import 'package:hirome_rental_shop_app/screens/order.dart';
import 'package:hirome_rental_shop_app/screens/order_cart.dart';
import 'package:hirome_rental_shop_app/services/shop_login.dart';
import 'package:hirome_rental_shop_app/widgets/animation_background.dart';
import 'package:hirome_rental_shop_app/widgets/cart_next_button.dart';
import 'package:hirome_rental_shop_app/widgets/custom_bottom_navigation_bar.dart';
import 'package:hirome_rental_shop_app/widgets/link_text.dart';
import 'package:hirome_rental_shop_app/widgets/login_title.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ShopLoginService shopLoginService = ShopLoginService();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    List<Widget> bodyWidgets = [
      OrderScreen(authProvider: authProvider),
      HistoryScreen(authProvider: authProvider),
    ];
    List<String> bodyTitles = ['注文', '注文履歴'];

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: shopLoginService.streamList(authProvider.authUser?.uid),
      builder: (context, snapshot) {
        ShopLoginModel? shopLogin;
        if (snapshot.hasData) {
          shopLogin = ShopLoginModel.fromSnapshot(snapshot.requireData);
        }
        if (shopLogin == null || shopLogin.id == '') {
          return Scaffold(
            backgroundColor: kRedColor,
            body: Stack(
              children: [
                const AnimationBackground(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const LoginTitle(),
                        const Text(
                          '管理者からログインをブロックされました。\nログイン申請から始めてください。',
                          style: TextStyle(
                            color: kYellowColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        LinkText(
                          label: 'ログイン申請から始める',
                          labelColor: kWhiteColor,
                          onTap: () async {
                            await authProvider.signOut();
                            authProvider.clearController();
                            if (!mounted) return;
                            pushReplacementScreen(context, const LoginScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (shopLogin.accept == false) {
          return Scaffold(
            body: Stack(
              children: [
                const AnimationBackground(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const LoginTitle(),
                        const Text(
                          '管理者へログイン申請を送信しました。\n承認まで今しばらくお待ちくださいませ。',
                          style: TextStyle(
                            color: kWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        LinkText(
                          label: 'ログイン申請をキャンセルする',
                          labelColor: kWhiteColor,
                          onTap: () async {
                            await authProvider.deleteShopLogin();
                            await authProvider.signOut();
                            authProvider.clearController();
                            if (!mounted) return;
                            pushReplacementScreen(context, const LoginScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold(
          body: bodyWidgets[currentIndex],
          floatingActionButton: CartNextButton(
            currentIndex: currentIndex,
            carts: authProvider.carts,
            onPressed: () => showBottomUpScreen(
              context,
              const OrderCartScreen(),
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() => currentIndex = index);
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.flatware),
                label: bodyTitles[0],
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.list),
                label: bodyTitles[1],
              ),
            ],
          ),
        );
      },
    );
  }
}
