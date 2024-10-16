
import 'package:flutter/material.dart';
import 'package:qrypt/base/utils/common_utils.dart';
import 'package:qrypt/utils/shared_pref.dart';

import 'app_theme.dart';

void setTheme({BuildContext? context}) {
  setThemeMode(isDarkMode());
  themeOf(context: context).setDarkThemeMode(isDarkMode());
}

bool isDarkMode() {
  var appTheme = getAppThemeMode();
  switch (appTheme) {
    case 0:
      return isSystemDarkMode;
    case 1:
      return false;
    case 2:
      return true;
  }
  return false;
}
