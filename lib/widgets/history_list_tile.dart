import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';

class HistoryListTile extends StatelessWidget {
  final Function()? onTap;

  const HistoryListTile({
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: kGreyColor)),
        ),
        child: const ListTile(
          title: Text(
            '醤油皿...他5点',
            style: TextStyle(
              color: kBlackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '注文日時 : 2023/07/06 15:44',
            style: TextStyle(
              color: kGreyColor,
              fontSize: 14,
            ),
          ),
          trailing: Chip(label: Text('配達完了')),
        ),
      ),
    );
  }
}
