import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/widgets/custom_product_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
        return const CustomProductCard();
      },
    );
  }
}
