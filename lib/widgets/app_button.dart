import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    super.key,
    this.onTap,
    required this.title,
  });
  final Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kPaddingHalf),
              color: Theme.of(context).primaryColor),
          child: Center(
              child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ))),
    );
  }
}
