import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/widgets/add_cart_button.dart';
import 'package:hirome_rental_shop_app/widgets/product_card.dart';
import 'package:hirome_rental_shop_app/widgets/quantity_button.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: kProductGrid,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: 30,
      itemBuilder: (context, index) {
        return ProductCard(
          onTap: () => showDialog(
            context: context,
            builder: (context) => const ProductDetailsDialog(),
          ),
        );
      },
    );
  }
}

class ProductDetailsDialog extends StatefulWidget {
  const ProductDetailsDialog({super.key});

  @override
  State<ProductDetailsDialog> createState() => _ProductDetailsDialogState();
}

class _ProductDetailsDialogState extends State<ProductDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            kDefaultImageUrl,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          const Text(
            '食器No. 2',
            style: TextStyle(
              color: kGreyColor,
              fontSize: 12,
            ),
          ),
          const Text(
            '醤油皿',
            style: TextStyle(
              color: kBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          QuantityButton(
            quantity: 1,
            unit: '枚',
            onRemoved: () {},
            onAdded: () {},
          ),
          const SizedBox(height: 8),
          AddCartButton(
            onPressed: () {},
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
