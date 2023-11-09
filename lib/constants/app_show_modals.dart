import 'package:flutter/material.dart';

Future<void> showMyBottomSheet(context, child) {
  return showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => child);
}
