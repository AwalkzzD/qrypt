
import 'package:flutter/material.dart';
import 'package:qrypt/base/components/screen_utils/flutter_screenutil.dart';

import '../../constants/app_styles.dart';
import '../../theme/app_theme.dart';

class CustomAlertDialog {

  static void showAlertDialog(
      BuildContext context, {
        String title = "Qrypt",
        String message = "",
        String positiveButtonText = "OK",
        Function()? onPositiveButtonClicked,
      }) {
    Widget continueButton = TextButton(
      onPressed: onPositiveButtonClicked ?? () {

      },
      child: Text(positiveButtonText, style: TextStyle(fontSize: 13.sp, fontFamily: fontFamilyPoppins, color: themeOf().appBarTextColor)),
    );

    AlertDialog alert = AlertDialog(
      scrollable: true,
      title: Text(title, style: TextStyle(fontSize: 16.sp, fontFamily: fontFamilyPoppins, color: themeOf().textPrimaryColor, fontWeight: FontWeight.w600)),
      content: Text(message, style: TextStyle(fontSize: 14.sp, fontFamily: fontFamilyPoppins, color: themeOf().textPrimaryColor)),
      actions: [
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}