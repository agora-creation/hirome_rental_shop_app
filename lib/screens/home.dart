import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';
import 'package:hirome_rental_shop_app/screens/history.dart';
import 'package:hirome_rental_shop_app/screens/order.dart';
import 'package:hirome_rental_shop_app/screens/order_cart.dart';
import 'package:hirome_rental_shop_app/screens/settings.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> body = [const OrderScreen(), const HistoryScreen()];
  List<String> bodyTitle = ['食器注文', '注文履歴'];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('${authProvider.shop?.name} : ${bodyTitle[currentIndex]}'),
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
      body: body[currentIndex],
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () => showBottomUpScreen(
                context,
                const OrderCartScreen(),
              ),
              label: const Text('注文に進む'),
              icon: const Icon(Icons.shopping_cart_checkout),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kGrey2Color,
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.flatware),
              label: '食器注文',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '注文履歴',
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
