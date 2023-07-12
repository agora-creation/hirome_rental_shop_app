import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/models/order.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';
import 'package:hirome_rental_shop_app/providers/order.dart';
import 'package:hirome_rental_shop_app/services/order.dart';
import 'package:hirome_rental_shop_app/widgets/cart_list.dart';
import 'package:hirome_rental_shop_app/widgets/custom_sm_button.dart';
import 'package:hirome_rental_shop_app/widgets/date_range_field.dart';
import 'package:hirome_rental_shop_app/widgets/history_list_tile.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  final AuthProvider authProvider;

  const HistoryScreen({
    required this.authProvider,
    super.key,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 16,
      ),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            DateRangeField(
              start: orderProvider.searchStart,
              end: orderProvider.searchEnd,
              onTap: () async {
                var selected = await showDateRangePicker(
                  context: context,
                  initialDateRange: DateTimeRange(
                    start: orderProvider.searchStart,
                    end: orderProvider.searchEnd,
                  ),
                  firstDate: kSearchFirstDate,
                  lastDate: kSearchLastDate,
                  saveText: '検索',
                );
                if (selected != null) {
                  orderProvider.searchChange(selected.start, selected.end);
                }
              },
            ),
            const Divider(height: 0, color: kGreyColor),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: orderService.streamList(
                  shop: widget.authProvider.shop!,
                  searchStart: orderProvider.searchStart,
                  searchEnd: orderProvider.searchEnd,
                ),
                builder: (context, snapshot) {
                  List<OrderModel> orders = [];
                  if (snapshot.hasData) {
                    for (DocumentSnapshot<Map<String, dynamic>> doc
                        in snapshot.data!.docs) {
                      orders.add(OrderModel.fromSnapshot(doc));
                    }
                  }
                  if (orders.isEmpty) {
                    return const Center(
                      child: Text('注文がありません'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      OrderModel order = orders[index];
                      return HistoryListTile(
                        order: order,
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => OrderDetailsDialog(
                            orderProvider: orderProvider,
                            order: order,
                          ),
                        ),
                      );
                    },
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
  final OrderProvider orderProvider;
  final OrderModel order;

  const OrderDetailsDialog({
    required this.orderProvider,
    required this.order,
    super.key,
  });

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
          Text(
            '注文日時 : ${dateText('yyyy/MM/dd HH:mm', widget.order.createdAt)}',
            style: const TextStyle(
              color: kGreyColor,
              fontSize: 14,
            ),
          ),
          Text(
            'ステータス : ${widget.order.statusText()}',
            style: const TextStyle(
              color: kGreyColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '注文した商品 : ',
            style: TextStyle(
              color: kGreyColor,
              fontSize: 14,
            ),
          ),
          Column(
            children: widget.order.carts.map((cart) {
              return CartList(cart: cart, viewDelivery: true);
            }).toList(),
          ),
          const SizedBox(height: 8),
          widget.order.status == 0
              ? CustomSmButton(
                  label: 'キャンセルする',
                  labelColor: kWhiteColor,
                  backgroundColor: kOrangeColor,
                  onPressed: () async {
                    String? error =
                        await widget.orderProvider.cancel(widget.order);
                    if (error != null) {
                      if (!mounted) return;
                      showMessage(context, error, false);
                      return;
                    }
                    if (!mounted) return;
                    showMessage(context, 'キャンセルに成功しました', true);
                    Navigator.pop(context);
                  },
                )
              : Container(),
          widget.order.status == 1
              ? CustomSmButton(
                  label: '再注文する',
                  labelColor: kWhiteColor,
                  backgroundColor: kBlueColor,
                  onPressed: () async {
                    String? error =
                        await widget.orderProvider.reCreate(widget.order);
                    if (error != null) {
                      if (!mounted) return;
                      showMessage(context, error, false);
                      return;
                    }
                    if (!mounted) return;
                    showMessage(context, '再注文に成功しました', true);
                    Navigator.pop(context);
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
