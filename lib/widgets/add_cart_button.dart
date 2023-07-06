import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';

class AddCartButton extends StatelessWidget {
  final Function()? onPressed;

  const AddCartButton({
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: kBlueColor,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(10),
        ),
        child: const Text(
          'カートに追加する',
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
