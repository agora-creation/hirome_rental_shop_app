import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';

class OrderProductWidget extends StatelessWidget {
  const OrderProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGreyColor)),
      ),
      padding: const EdgeInsets.all(4),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '食器No. 2',
                style: TextStyle(
                  color: kGreyColor,
                  fontSize: 12,
                ),
              ),
              Text(
                '醤油皿',
                style: TextStyle(
                  color: kBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '希望数量',
                    style: TextStyle(
                      color: kGreyColor,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '15枚',
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '納品数量',
                    style: TextStyle(
                      color: kGreyColor,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '15枚',
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
