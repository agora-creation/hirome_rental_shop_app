import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';

class FavoritesScreen extends StatefulWidget {
  final AuthProvider authProvider;

  const FavoritesScreen({
    required this.authProvider,
    super.key,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: kWhiteColor,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: kBlackColor,
            size: 32.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${widget.authProvider.shop?.name} : お気に入り設定',
          style: const TextStyle(color: kBlackColor),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('保存'),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
