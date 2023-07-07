import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';

class DateRangeField extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const DateRangeField({
    required this.label,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(color: kGreyColor),
      ),
      trailing: const Icon(Icons.date_range, color: kGreyColor),
      onTap: onTap,
    );
  }
}
