import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/widgets/custom_text_button.dart';
import 'package:hirome_rental_shop_app/widgets/history_list_tile.dart';
import 'package:hirome_rental_shop_app/widgets/order_product_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              title: const Text(
                '期間で検索',
                style: TextStyle(color: kGreyColor),
              ),
              trailing: const Icon(Icons.date_range, color: kGreyColor),
              onTap: () {},
            ),
            const Divider(height: 0, color: kGreyColor),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return HistoryListTile(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => const OrderDetailsDialog(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderDetailsDialog extends StatefulWidget {
  const OrderDetailsDialog({super.key});

  @override
  State<OrderDetailsDialog> createState() => _OrderDetailsDialogState();
}

class _OrderDetailsDialogState extends State<OrderDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '注文日時 : 2023/07/06 15:25',
            style: TextStyle(
              color: kGreyColor,
              fontSize: 14,
            ),
          ),
          const Text(
            'ステータス : 配達完了',
            style: TextStyle(
              color: kGreyColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '注文した食器 : ',
            style: TextStyle(
              color: kGreyColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          const Column(
            children: [
              OrderProductWidget(),
              OrderProductWidget(),
              OrderProductWidget(),
              OrderProductWidget(),
              OrderProductWidget(),
              OrderProductWidget(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                labelText: 'キャンセルする',
                labelColor: kWhiteColor,
                backgroundColor: kOrangeColor,
                onPressed: () {},
              ),
              CustomTextButton(
                labelText: '再注文する',
                labelColor: kWhiteColor,
                backgroundColor: kBlueColor,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
