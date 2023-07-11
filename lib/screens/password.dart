import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';
import 'package:hirome_rental_shop_app/widgets/custom_text_form_field.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PasswordScreen extends StatefulWidget {
  final AuthProvider authProvider;

  const PasswordScreen({
    required this.authProvider,
    super.key,
  });

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController newPassword = TextEditingController();

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
          '${widget.authProvider.shop?.name} : パスワード変更',
          style: const TextStyle(color: kBlackColor),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String? error = await widget.authProvider.updatePassword(
                newPassword.text,
              );
              if (error != null) {
                if (!mounted) return;
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(message: error),
                  snackBarPosition: SnackBarPosition.bottom,
                );
                return;
              }
              if (!mounted) return;
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.success(message: 'パスワードを変更しました'),
                snackBarPosition: SnackBarPosition.bottom,
              );
            },
            child: const Text('保存'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              controller: newPassword,
              maxLines: 1,
              label: '新しいパスワード',
              color: kBlackColor,
              prefix: Icons.key,
            ),
          ],
        ),
      ),
    );
  }
}
