import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/widgets/custom_lg_button.dart';
import 'package:hirome_rental_shop_app/widgets/order_product_widget.dart';

class OrderCartScreen extends StatefulWidget {
  const OrderCartScreen({super.key});

  @override
  State<OrderCartScreen> createState() => _OrderCartScreenState();
}

class _OrderCartScreenState extends State<OrderCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: const Text(
          '珍味堂 : 注文確認',
          style: TextStyle(color: kBlackColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: kBlackColor),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '注文の内容を確認してください。\n間違いなければ『注文する』ボタンを押してください。',
              style: TextStyle(color: kRedColor),
            ),
            const SizedBox(height: 16),
            const Text('注文する食器'),
            const OrderProductWidget(),
            const OrderProductWidget(),
            const OrderProductWidget(),
            const SizedBox(height: 24),
            CustomLgButton(
              label: '注文する',
              labelColor: kWhiteColor,
              backgroundColor: kBlueColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
