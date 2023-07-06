import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/widgets/product_card.dart';

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
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '薪は狼煙を上げるのに使います。',
                    style: TextStyle(fontSize: 14),
                  ),
                  const Text(
                    '狼煙を上げるのに必要な薪の数は1本です。',
                    style: TextStyle(fontSize: 14),
                  ),
                  const Text(
                    '薪は最大10本持つことができ、薪は15分毎に1本回復します。',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
