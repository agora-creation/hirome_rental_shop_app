import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/screens/favorites.dart';
import 'package:hirome_rental_shop_app/screens/login.dart';
import 'package:hirome_rental_shop_app/screens/password.dart';
import 'package:hirome_rental_shop_app/widgets/link_text.dart';
import 'package:hirome_rental_shop_app/widgets/setting_list_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
        title: const Text(
          '珍味堂 : 設定',
          style: TextStyle(color: kBlackColor),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: kBlackColor),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingListTile(
              iconData: Icons.key,
              label: 'パスワード変更',
              topBorder: true,
              onTap: () => pushScreen(context, const PasswordScreen()),
            ),
            SettingListTile(
              iconData: Icons.favorite,
              label: 'お気に入り設定',
              onTap: () => pushScreen(context, const FavoritesScreen()),
            ),
            const SizedBox(height: 24),
            Center(
              child: LinkText(
                label: 'ログアウト',
                labelColor: kRedColor,
                onTap: () {
                  pushReplacementScreen(context, const LoginScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
