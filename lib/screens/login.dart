import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/providers/auth.dart';
import 'package:hirome_rental_shop_app/screens/home.dart';
import 'package:hirome_rental_shop_app/widgets/animation_background.dart';
import 'package:hirome_rental_shop_app/widgets/custom_lg_button.dart';
import 'package:hirome_rental_shop_app/widgets/custom_text_form_field.dart';
import 'package:hirome_rental_shop_app/widgets/login_title.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool buttonDisabled = false;
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          const AnimationBackground(),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const LoginTitle(),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          errorText != ''
                              ? Text(
                                  errorText,
                                  style: const TextStyle(
                                    color: kRedColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container(),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: authProvider.number,
                            textInputType: TextInputType.text,
                            maxLines: 1,
                            label: '店舗番号',
                            color: kBlackColor,
                            prefix: Icons.food_bank,
                          ),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: authProvider.requestName,
                            textInputType: TextInputType.name,
                            maxLines: 1,
                            label: 'あなたの名前',
                            color: kBlackColor,
                            prefix: Icons.person,
                          ),
                          const SizedBox(height: 16),
                          buttonDisabled
                              ? const CustomLgButton(
                                  label: 'ログイン',
                                  labelColor: kWhiteColor,
                                  backgroundColor: kGreyColor,
                                  onPressed: null,
                                )
                              : CustomLgButton(
                                  label: 'ログイン',
                                  labelColor: kWhiteColor,
                                  backgroundColor: kBlueColor,
                                  onPressed: () async {
                                    setState(() {
                                      buttonDisabled = true;
                                    });
                                    String? error = await authProvider.signIn();
                                    if (error != null) {
                                      setState(() {
                                        buttonDisabled = false;
                                        errorText = error;
                                      });
                                      return;
                                    }
                                    authProvider.clearController();
                                    if (!mounted) return;
                                    showMessage(context, 'ログイン申請を送信しました', true);
                                    pushReplacementScreen(
                                      context,
                                      const HomeScreen(),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
