import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';

class CustomTextButton extends StatelessWidget {
  final String labelText;
  final Color labelColor;
  final Color backgroundColor;
  final Function()? onPressed;

  const CustomTextButton({
    this.labelText = '',
    this.labelColor = kWhiteColor,
    this.backgroundColor = kGreyColor,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      ),
      child: Text(
        labelText,
        style: TextStyle(color: labelColor),
      ),
    );
  }
}
