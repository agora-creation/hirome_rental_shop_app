import 'package:flutter/material.dart';

class CustomSmButton extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color backgroundColor;
  final Function()? onPressed;

  const CustomSmButton({
    required this.label,
    required this.labelColor,
    required this.backgroundColor,
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
          backgroundColor: backgroundColor,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
