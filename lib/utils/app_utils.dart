import 'dart:io';
import 'dart:math';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'color_resource.dart';
import 'custom_text.dart';
import 'fonts.dart';

class DebugMode {
  static bool get isInDebugMode {
    bool inDebugMode = true; // true   shows url
    //assert(inDebugMode = true);
    return inDebugMode;
  }
}

class AppUtils {
  static String getRandomString({int length = 15}) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static String? capitalize(String? input) {
    if (input == null) {
      input = "";
    }
    if (input.length == 0) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  static void showToast(String? text, {Color color = Colors.red}) {
    Fluttertoast.showToast(
      msg: text ?? "",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static void showSnackBarText(BuildContext context, String text,
      {Color color = ColorResource.FORM_ERROR}) {
    assert(text != null);
    assert(context != null);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color.withOpacity(0.9),
        content: CustomText(
          text,
          fontSize: 16,
          color: ColorResource.WHITE,
          font: Font.LatoMedium,
        ),
      ),
    );
  }

  static bool isPositive(int number) {
    return number > 0;
  }

  static bool isNegative(int number) {
    return number < 0;
  }

  static bool isZero(int number) {
    return number == 0;
  }

  static File getFile(String filePath) {
    File orgFile = File(filePath);
    return orgFile;
  }

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static double getHeight(double width) {
    double height = (4 * width) / 3;
    return height;
  }

  static String? validateDate(String value) {
    if (value.isEmpty) {
      return "Enter Expiry Date";
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(new RegExp(r'(\/)'))) {
      var split = value.split(new RegExp(r'(\/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static String enumName(String string) {
    return string;
  }

  static void formatHHMMSS(String slotTime) {}

  static int generateRandomNumber(RemoteMessage/*Map<String, dynamic>?*/ message) {

    if (Platform.isIOS) {
      if(message !=null){
      if /*(message["notification_type"] == "conversation-invite")*/(message.messageType != null) {
        return 0;
      } else {
        var rng = new Random();
        return rng.nextInt(100);
      }
      } else {
        var rng = new Random();
        return rng.nextInt(100);
      }
    } else {
      if(message !=null) {
        if /*(message["notification"]["notification_type"] == "conversation-invite")*/(message.messageType != null) {
          return 0;
        } else {
          var rng = new Random();
          return rng.nextInt(100);
        }
      } else {
        var rng = new Random();
        return rng.nextInt(100);
      }
    }
  }
}
