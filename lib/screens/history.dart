import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/widgets/history_list_tile.dart';

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
                  return const HistoryListTile();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
