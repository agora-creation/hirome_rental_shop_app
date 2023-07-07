import 'package:flutter/material.dart';
import 'package:hirome_rental_shop_app/common/functions.dart';
import 'package:hirome_rental_shop_app/common/style.dart';
import 'package:hirome_rental_shop_app/screens/home.dart';
import 'package:hirome_rental_shop_app/widgets/custom_lg_button.dart';
import 'package:hirome_rental_shop_app/widgets/custom_text_form_field.dart';
import 'package:hirome_rental_shop_app/widgets/login_title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: TextEditingController(),
                        textInputType: TextInputType.number,
                        maxLines: 1,
                        label: '店舗番号',
                        color: kBlackColor,
                        prefix: Icons.food_bank,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: TextEditingController(),
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                        maxLines: 1,
                        label: 'パスワード',
                        color: kBlackColor,
                        prefix: Icons.key,
                      ),
                      const SizedBox(height: 16),
                      CustomLgButton(
                        label: 'ログイン',
                        labelColor: kWhiteColor,
                        backgroundColor: kBlueColor,
                        onPressed: () {
                          pushReplacementScreen(context, const HomeScreen());
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
    );
  }
}
