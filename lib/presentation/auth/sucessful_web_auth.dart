import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_constants.dart';
import '../../styles.dart';
import 'login_screen.dart';

class SuccessfulWebAuth extends StatelessWidget {
  const SuccessfulWebAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
          child: Container(
              padding: const EdgeInsets.all(kPaddingDefault * 2),
              decoration: BoxDecoration(
                  color: tWhiteColor, borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const AuthHeaderWidget(),
                  Text(
                    "Successful!",
                    style: TextStyles.h1,
                  ),
                  kVSpacingHalf,
                  const Icon(
                    Ionicons.checkmark_circle_outline,
                    size: 16 * 5,
                    color: Colors.green,
                  ),
                  kVSpacingDefault,
                  Text(
                    "You have successfully authenticated",
                    style: TextStyles.body1,
                  ),
                  kVSpacingDefault,
                  const AuthButton(
                    loading: false,
                    title: "Copy Access Keys",
                  ),
                ],
              ))),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.loading, required this.title});
  final bool loading;
  final String title;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: tDarkColor,
                  backgroundColor: Colors.black12,
                )),
          )
        : Container(
            width: 250,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault),
            decoration: BoxDecoration(
              color: tPrimaryColor,
              borderRadius: BorderRadius.circular(kPaddingHalf),
            ),
            child: InkWell(
                onTap: () {
                  // context.read<LoginCubit>().logInWithCredentials();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Ionicons.key,
                      color: tWhiteColor,
                    ),
                    kHSpacingHalf,
                    Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyles.h3.copyWith(color: tWhiteColor),
                    ),
                  ],
                )),
          );
  }
}
