library app_constants;

import 'package:flutter/material.dart';

const double kPaddingDefault = 16.0;
const double kPaddingHalf = 8.0;
const double kPaddingQuarter = 4.0;
const double kMaxContentWidth = 600;

const double kInputBorderRadius = 6;

const SizedBox kHSpacingDefault = SizedBox(width: kPaddingDefault);
const SizedBox kHSpacingHalf = SizedBox(width: kPaddingHalf);
const SizedBox kHSpacingQuarter = SizedBox(width: kPaddingQuarter);

const SizedBox kVSpacingDefault = SizedBox(height: kPaddingDefault);
const SizedBox kVSpacingHalf = SizedBox(height: kPaddingHalf);
const SizedBox kVSpacingQuarter = SizedBox(height: kPaddingQuarter);

Future<void> _showBottomSheet(context, Widget child) async {
  return showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => child);
}
