import 'package:intl/intl.dart';
import 'package:doculode/core/utils/logger.dart';

class MessageModel {
  String title, message;

  MessageModel(this.title, this.message);
}

class ErrorStrings {
  static const String userNotFound = "user-not-found";
  static const String internalError = "internal-error";
  static const String userAlreadyExist = "email-already-exists";
  static const String wrongPassword = "wrong-password";
  static const String noNetwork = 'network-request-failed';
  static const String tooManyRequests = 'too-many-requests';
  static const String codeExpired = 'expired-action-code';
  static const String invalidCode = 'invalid-action-code';

  static MessageModel interpretErrorMessage(String baseError, [int left = 8]) {
    log(baseError);

    if (baseError == wrongPassword) {
      return MessageModel(
          "Invalid Password", "After $left attempt you will be blocked!");
    } else if (baseError == userNotFound) {
      return MessageModel(
          "User not found", "Sign up or enter valid email address.");
    } else if (baseError == userAlreadyExist) {
      return MessageModel("User found", "Email already in use, sign in.");
    } else if (baseError == internalError) {
      return MessageModel(
          "Unexpected error", "Reload the page or reopen the site in new tab");
    } else if (baseError == noNetwork) {
      return MessageModel("Network error", "Fix your internet connection.");
    } else if (baseError == codeExpired) {
      return MessageModel("Expired!", "The password reset link has expired.");
    } else if (baseError == invalidCode) {
      return MessageModel(
          "Invalid link!", "The link is  malformed or has already been used.");
    }
    return MessageModel("Unexpected Error", "Reopen the page in new tab");
  }
}

class FormattedString {
  static int getMonthNo(String month) {
    switch (month) {
      case "Jan":
        return 1;
      case "Feb":
        return 2;
      case "Mar":
        return 3;
      case "Apr":
        return 4;
      case "May":
        return 5;
      case "Jun":
        return 6;
      case "Jul":
        return 7;
      case "Aug":
        return 8;
      case "Sep":
        return 9;
      case "Oct":
        return 10;
      case "Nov":
        return 11;
      default:
        return 12;
    }
  }

  static String getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      default:
        return "Dec";
    }
  }

  static String id(String value) {
    if (value.length < 6) {
      return value;
    }
    String dob = value.substring(0, 6);
    String gender = value.substring(6, 10);
    String nationality = value.substring(10, 12);
    String validity = value.substring(12);

    return '$dob  $gender  $nationality  $validity';
  }

  static double amountToDouble(String string) {
    if (string == "") return 0.0;
    var noR = string.replaceAll(RegExp('[\\s+R]'), '');
    return double.parse(noR);
  }

  static String doubleToString(double? value) {
    // double value = double.parse(value);
    if (value == null || value == 0.0) {
      return 'R0.00';
    }
    final formatter = NumberFormat.simpleCurrency(locale: "en_za");

    String newText = formatter.format(value).replaceAll(',', '.');
    if (newText == 'R0.00') {
      newText = '';
    }
    return newText;
    // return value.copyWith(
    //     text: newText,
    //     selection: TextSelection.collapsed(offset: newText.length));
  }
}
