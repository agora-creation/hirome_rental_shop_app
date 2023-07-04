import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('珍味堂: 食器注文'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: 30,
        itemBuilder: (ctx, i) {
          return Card(
            elevation: 5,
            child: Container(
              height: 400,
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/default.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Padding(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '食器No. 2',
                              style: TextStyle(
                                color: kGreyColor,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              '醤油皿',
                              style: TextStyle(
                                color: kBlackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('注文に進む'),
        icon: const Icon(Icons.shopping_cart_checkout),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
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
    );
  }
}
