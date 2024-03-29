import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/models/cart.dart';
import 'package:hirome_rental_shop_app/models/product.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';
import 'package:hirome_rental_shop_app/screens/order_cart.dart';
import 'package:hirome_rental_shop_app/screens/settings.dart';
import 'package:hirome_rental_shop_app/services/product.dart';
import 'package:hirome_rental_shop_app/widgets/animation_background.dart';
import 'package:hirome_rental_shop_app/widgets/custom_image.dart';
import 'package:hirome_rental_shop_app/widgets/custom_lg_button.dart';
import 'package:hirome_rental_shop_app/widgets/custom_sm_button.dart';
import 'package:hirome_rental_shop_app/widgets/link_text.dart';
import 'package:hirome_rental_shop_app/widgets/product_card.dart';
import 'package:hirome_rental_shop_app/widgets/quantity_button.dart';

class OrderScreen extends StatefulWidget {
  final AuthProvider authProvider;

  const OrderScreen({
    required this.authProvider,
    super.key,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  ProductService productService = ProductService();

  void _init() async {
    await widget.authProvider.initCarts();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const AnimationBackground(),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.authProvider.shop?.name} : 注文',
                      style: const TextStyle(
                        color: kWhiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => showBottomUpScreen(
                        context,
                        const SettingsScreen(),
                      ),
                      child: const Icon(
                        Icons.settings,
                        color: kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '注文したい商品をタップしてください',
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 14,
                ),
              ),
              widget.authProvider.carts.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomSmButton(
                        label: '注文に進む',
                        labelColor: kWhiteColor,
                        backgroundColor: kRedColor,
                        onPressed: () => showBottomUpScreen(
                          context,
                          const OrderCartScreen(),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 4),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: productService.streamList(),
                  builder: (context, snapshot) {
                    List<ProductModel> products = [];
                    List<String> favorites =
                        widget.authProvider.shop?.favorites ?? [];
                    if (snapshot.hasData) {
                      for (DocumentSnapshot<Map<String, dynamic>> doc
                          in snapshot.data!.docs) {
                        ProductModel product = ProductModel.fromSnapshot(doc);
                        var contain =
                            favorites.where((e) => e == product.number);
                        if (contain.isNotEmpty) {
                          products.add(product);
                        }
                      }
                    }
                    if (products.isEmpty) {
                      return const Center(
                        child: Text(
                          '注文できる商品がありません\n注文商品設定をご確認ください',
                          style: TextStyle(color: kWhiteColor),
                        ),
                      );
                    }
                    return GridView.builder(
                      gridDelegate: kProductGrid,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        bottom: 40,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        ProductModel product = products[index];
                        return ProductCard(
                          product: product,
                          carts: widget.authProvider.carts,
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => ProductDetailsDialog(
                              authProvider: widget.authProvider,
                              product: product,
                            ),
                          ).then((value) {
                            widget.authProvider.initCarts();
                          }),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductDetailsDialog extends StatefulWidget {
  final AuthProvider authProvider;
  final ProductModel product;

  const ProductDetailsDialog({
    required this.authProvider,
    required this.product,
    super.key,
  });

  @override
  State<ProductDetailsDialog> createState() => _ProductDetailsDialogState();
}

class _ProductDetailsDialogState extends State<ProductDetailsDialog> {
  int requestQuantity = 0;
  CartModel? cart;

  void _init() async {
    int tmpRequestQuantity = 0;
    for (CartModel cartModel in widget.authProvider.carts) {
      if (cartModel.number == widget.product.number) {
        tmpRequestQuantity = cartModel.requestQuantity;
        cart = cartModel;
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
      content: SingleChildScrollView(
        child: Column(
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
                if (requestQuantity == 0) return;
                setState(() {
                  requestQuantity -= 1;
                });
              },
              onRemoved10: () {
                if (requestQuantity == 0) return;
                setState(() {
                  if (requestQuantity <= 10) {
                    requestQuantity = 0;
                  } else {
                    requestQuantity -= 10;
                  }
                });
              },
              onAdded: () {
                setState(() {
                  requestQuantity += 1;
                });
              },
              onAdded10: () {
                setState(() {
                  requestQuantity += 10;
                });
              },
            ),
            const SizedBox(height: 8),
            CustomLgButton(
              label: cart != null ? '数量を変更する' : 'カートに入れる',
              labelColor: kWhiteColor,
              backgroundColor: kBlueColor,
              onPressed: () async {
                if (requestQuantity > 0) {
                  await widget.authProvider.addCarts(
                    widget.product,
                    requestQuantity,
                  );
                } else if (cart != null) {
                  await widget.authProvider.removeCart(cart!);
                }
                if (!mounted) return;
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
            cart != null
                ? Center(
                    child: LinkText(
                      label: 'カートから削除する',
                      labelColor: kRedColor,
                      onTap: () async {
                        if (cart == null) return;
                        await widget.authProvider.removeCart(cart!);
                        if (!mounted) return;
                        Navigator.pop(context);
                      },
                    ),
                  )
                : Container(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
