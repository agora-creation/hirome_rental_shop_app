import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                    kDefaultImageUrl,
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
  }
}
