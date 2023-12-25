import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';
import 'package:hirome_rental_shop_app/screens/favorites.dart';
import 'package:hirome_rental_shop_app/screens/login.dart';
import 'package:hirome_rental_shop_app/widgets/link_text.dart';
import 'package:hirome_rental_shop_app/widgets/setting_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
        backgroundColor: kWhiteColor,
        title: Text(
          '${authProvider.shop?.name} : 設定',
          style: const TextStyle(color: kBlackColor),
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
              iconData: Icons.favorite,
              label: '注文商品設定',
              topBorder: true,
              onTap: () => pushScreen(
                context,
                FavoritesScreen(authProvider: authProvider),
              ),
            ),
            SettingListTile(
              iconData: Icons.backup,
              label: '過去のデータを確認',
              onTap: () async {
                String number = authProvider.shop?.number ?? '';
                final url = Uri.parse(
                  'https://hirome.co.jp/rental/history/access.php?number=$number',
                );
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
            ),
            const SizedBox(height: 24),
            Center(
              child: LinkText(
                label: '初期化する(店舗ログイン申請から始める)',
                labelColor: kRedColor,
                onTap: () async {
                  await authProvider.deleteShopLogin();
                  await authProvider.signOut();
                  authProvider.clearController();
                  if (!mounted) return;
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
