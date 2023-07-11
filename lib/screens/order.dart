import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/models/cart.dart';
import 'package:hirome_rental_shop_app/models/product.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';
import 'package:hirome_rental_shop_app/services/cart.dart';
import 'package:hirome_rental_shop_app/services/product.dart';
import 'package:hirome_rental_shop_app/widgets/custom_image.dart';
import 'package:hirome_rental_shop_app/widgets/custom_lg_button.dart';
import 'package:hirome_rental_shop_app/widgets/product_card.dart';
import 'package:hirome_rental_shop_app/widgets/quantity_button.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  CartService cartService = CartService();
  ProductService productService = ProductService();
  List<CartModel> carts = [];

  void _getCart() async {
    List<CartModel> tmpCarts = await cartService.get();
    setState(() {
      carts = tmpCarts;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCart();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: productService.streamList(),
      builder: (context, snapshot) {
        List<ProductModel> products = [];
        List<String> favorites = authProvider.shop?.favorites ?? [];
        if (snapshot.hasData) {
          for (DocumentSnapshot<Map<String, dynamic>> doc
              in snapshot.data!.docs) {
            ProductModel product = ProductModel.fromSnapshot(doc);
            var contain = favorites.where((e) => e == product.number);
            if (contain.isNotEmpty) {
              products.add(product);
            }
          }
        }
        if (products.isEmpty) {
          return const Center(
            child: Text(
              '注文できる商品がありません',
              style: TextStyle(color: kWhiteColor),
            ),
          );
        }
        return GridView.builder(
          gridDelegate: kProductGrid,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: products.length,
          itemBuilder: (context, index) {
            ProductModel product = products[index];
            return ProductCard(
              product: product,
              carts: carts,
              onTap: () => showDialog(
                context: context,
                builder: (context) => ProductDetailsDialog(product: product),
              ).then((value) {
                _getCart();
              }),
            );
          },
        );
      },
    );
  }
}

class ProductDetailsDialog extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsDialog({
    required this.product,
    super.key,
  });

  @override
  State<ProductDetailsDialog> createState() => _ProductDetailsDialogState();
}

class _ProductDetailsDialogState extends State<ProductDetailsDialog> {
  CartService cartService = CartService();
  int requestQuantity = 1;

  void _init() async {
    List<CartModel> carts = await cartService.get();
    int tmpRequestQuantity = 1;
    for (CartModel cart in carts) {
      if (cart.number == widget.product.number) {
        tmpRequestQuantity = cart.requestQuantity;
      }
    }
    setState(() {
      requestQuantity = tmpRequestQuantity;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: CustomImage(widget.product.image),
          ),
          const SizedBox(height: 8),
          Text(
            '商品番号 : ${widget.product.number}',
            style: const TextStyle(
              color: kGreyColor,
              fontSize: 12,
            ),
          ),
          Text(
            widget.product.name,
            style: const TextStyle(
              color: kBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          QuantityButton(
            quantity: requestQuantity,
            unit: widget.product.unit,
            onRemoved: () {
              if (requestQuantity == 1) return;
              setState(() {
                requestQuantity -= 1;
              });
            },
            onAdded: () {
              setState(() {
                requestQuantity += 1;
              });
            },
          ),
          const SizedBox(height: 8),
          CustomLgButton(
            label: 'カートに入れる',
            labelColor: kWhiteColor,
            backgroundColor: kBlueColor,
            onPressed: () async {
              await cartService.add(
                widget.product,
                requestQuantity,
              );
              if (!mounted) return;
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
