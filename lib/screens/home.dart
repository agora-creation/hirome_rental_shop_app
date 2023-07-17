import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';
import 'package:hirome_rental_shop_app/screens/history.dart';
import 'package:hirome_rental_shop_app/screens/login.dart';
import 'package:hirome_rental_shop_app/screens/order.dart';
import 'package:hirome_rental_shop_app/screens/order_cart.dart';
import 'package:hirome_rental_shop_app/screens/settings.dart';
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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    List<Widget> bodyWidgets = [
      OrderScreen(authProvider: authProvider),
      HistoryScreen(authProvider: authProvider),
    ];
    List<String> bodyTitles = ['注文', '注文履歴'];

    if (authProvider.loginCheck()) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:
              Text('${authProvider.shop?.name} : ${bodyTitles[currentIndex]}'),
          actions: [
            IconButton(
              onPressed: () => showBottomUpScreen(
                context,
                const SettingsScreen(),
              ),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
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
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () async {
                await authProvider.reLoginCheck();
                if (!mounted) return;
                pushReplacementScreen(context, const HomeScreen());
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const LoginTitle(),
                const Column(
                  children: [
                    Text(
                      '管理者へログイン申請を送りました。\n承認まで今しばらくお待ちくださいませ。',
                      style: TextStyle(color: kWhiteColor),
                    ),
                  ],
                ),
                LinkText(
                  label: 'ログインへ戻る',
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
      );
    }
  }
}
