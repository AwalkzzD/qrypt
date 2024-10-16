
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrypt/base/bloc/base_bloc.dart';
import 'package:qrypt/base/bloc/base_bloc_provider.dart';
import 'package:qrypt/base/constants/app_colors.dart';
import 'package:qrypt/base/constants/app_widgets.dart';
import 'package:qrypt/base/theme/theme_utils.dart';
import 'package:qrypt/utils/shared_pref.dart';
import 'package:qrypt/utils/widgets/common_widgets.dart';
import 'package:rxdart/rxdart.dart';

class AppTheme extends BasePageBloc {
  late BehaviorSubject<bool> isDarkModeTheme;
  late BehaviorSubject<double> scaleFactor;

  AppTheme() {
    isDarkModeTheme = BehaviorSubject.seeded(isDarkMode());
    scaleFactor = BehaviorSubject.seeded(getScaleFactor());
  }

  void refresh() {
    scaleFactor.add(getScaleFactor());
  }

  void setDarkThemeMode(bool flag) {
    if (!isDarkModeTheme.isClosed) {
      isDarkModeTheme.add(flag);
    }
  }

  void setScaleFactor(double size) {
    if (!scaleFactor.isClosed) {
      scaleFactor.add(size);
    }
  }

  @override
  void dispose() {
    isDarkModeTheme.close();
    scaleFactor.close();
    super.dispose();
  }

  bool get isLightMode => !getThemeMode();

  SystemUiOverlayStyle uiOverlayStyleCommon() {
    if (isLightMode) {
      return SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      );
    } else {
      return SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: const Color(0xFF1F1F1F),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      );
    }
  }

  SystemUiOverlayStyle uiOverlayStyleDialog() {
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    );
  }

  SystemUiOverlayStyle uiOverlayStyleDrawer() {
    if (isLightMode) {
      return SystemUiOverlayStyle.light.copyWith(
        statusBarColor: themeOf().accentColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      );
    } else {
      return SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: const Color(0xFF1F1F1F),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      );
    }
  }

  SystemUiOverlayStyle get uiOverlayStyle =>
      isLightMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;


  /// imp colors (add other if found any)
  ///
  /// Color(0xFF64B6AC) - cyan / primary
  /// Color(0xFF577187) - card color
  /// Color(0xFF293241) - dark theme scaffold (bg)
  /// Color(0xFFBABABA) - grey (text sub heading)

  Color get primaryColor => const Color(0xFF64B6AC);
  Color get accentColor => const Color(0xFF577187);
  Color get greyColor => const Color(0xFFBABABA);
  Color get darkThemeBgColor => const Color(0xFF293241);
  Color get lightThemeBgColor => const Color(0xFFFFFFFF);

  Color get scaffoldColor => isLightMode ? lightThemeBgColor : darkThemeBgColor;

  Color get textPrimaryColor => isLightMode ? darkThemeBgColor : lightThemeBgColor;

  Color get cardBgColor => isLightMode ? lightThemeBgColor : accentColor;
  Color get cardBorderColor => isLightMode ? darkThemeBgColor : accentColor;

  Color get dividerColor => isLightMode ? lightThemeBgColor : accentColor;

  // add & update required colors and remove unnecessary ones
  // add light - dark colors for text field bgs, bottom bar color, icon color, button bg color etc

  Color get appBarColor => isLightMode ? Colors.white : const Color(0xFF1F1F1F);

  Color get appBarTextColor => isLightMode ? accentColor : Colors.white;

  Color get progressBgColor =>
      isLightMode ? Colors.white : const Color(0xFF1F1F1F);


  Color get bottomBarColor =>
      isLightMode ? Colors.white : const Color(0xFF1F1F1F);

  Color get bottomBarShadowColor =>
      isLightMode ? const Color(0x1A08263A) : const Color(0x1A08263A);

  Color get dialogBgColor =>
      isLightMode ? Colors.white : const Color(0xFF1F1F1F);

  Color get dropShadowColor =>
      isLightMode ? const Color(0xFFECEEF0) : const Color(0x1A08263A);

  Color get lightAccentColor1 => const Color(0x577F1417);

  Color get lightAccentColor2 => const Color(0x1A7F1417);

  Color get borderColor =>
      isLightMode ? const Color(0x2E08263A) : const Color(0x29FFFFFF);

  Color get orangeColor => const Color(0xFFF8A44C);

  Color? get iconSelectedBottomBarColor => isLightMode ? null : Colors.white;

  Color? get iconUnSelectedBottomBarColor =>
      isLightMode ? null : const Color(0x29FFFFFF);

  Color? get iconColor => isLightMode ? null : Colors.white;

  Color get fieldBorderColor =>
      isLightMode ? const Color(0x337F1417) : Colors.black.withOpacity(0.7);

  Color get fieldBgColor =>
      isLightMode ? const Color(0x0D7F1417) : const Color(0xFF272727);

  Color get textFieldHeaderColor =>
      isLightMode ? accentColor : const Color(0xFF939393);

  Color get textFieldHintColor =>
      isLightMode ? textSecondaryColor : const Color(0x808D8D8D);

  Color get textFieldBorderColor =>
      isLightMode ? const Color(0x1F08263A) : const Color(0x4C939393);

  Color get textFieldBgColor =>
      isLightMode ? Colors.white : const Color(0xFF272727);

  Color get dropdownBorderColor =>
      isLightMode ? const Color(0x1F08263A) : const Color(0x4C939393);

  Color get dropdownBgColor =>
      isLightMode ? Colors.white : const Color(0xFF272727);

  Color get dropdownHintColor =>
      isLightMode ? textSecondaryColor : const Color(0x808D8D8D);

  Color get cardDropShadowColor =>
      isLightMode ? const Color(0x1408263A) : Colors.transparent;

  Color get stepperLineColor =>
      isLightMode ? const Color(0x2E08263A) : const Color(0x33939393);

  Color get cardHighlightBgColor =>
      isLightMode ? const Color(0x0F08263A) : const Color(0xFF272727);

  Color get textPrimaryHeader =>
      isLightMode ? accentColor : const Color(0xFF939393);

  Color get textSecondaryColor =>
      isLightMode ? const Color(0xB208263A) : const Color(0xFF939393);

  Color get qrCodeBorderColor =>
      isLightMode ? border26B : const Color(0xFF939393);

  Color get textSubSecondaryColor =>
      isLightMode ? const Color(0xFF8D8D8D) : Colors.white;

  Color get textHintColor => const Color(0xFF8D8D8D).withOpacity(0.5);

  Color get textAccentColor => isLightMode ? accentColor : Colors.white;

  Color get textColor1 => const Color(0xFF5A5A5A);

  Color get hintTextColor => const Color(0x808D8D8D);

  Color get disableTextColor =>
      isLightMode ? const Color(0xB208263A) : textSecondaryColor;

  Color get grey1Color => const Color(0xFF8D8D8D);

  Color get grey2Color => const Color(0x1208263A);

  Color get activeSwitchBorderBgColor =>
      isLightMode ? accentColor : const Color(0xFF939393);

  Color get inActiveSwitchBorderBgColor =>
      isLightMode ? const Color(0xA808263A) : const Color(0x29FFFFFF);

  Color get activeSwitchBgColor =>
      isLightMode ? const Color(0xFFF3E3E3) : const Color(0x1F08263A);

  Color get inActiveSwitchBgColor =>
      isLightMode ? const Color(0x1F08263A) : Colors.black.withOpacity(0.4);

  Color get activeSwitchToggleColor =>
      isLightMode ? primaryColor : const Color(0xFF939393);

  Color get inActiveSwitchToggleColor =>
      isLightMode ? const Color(0xFF082539) : const Color(0x29FFFFFF);

  Color get tabSelectedIndicatorColor =>
      isLightMode ? accentColor : Colors.white;

  Color get tabUnSelectedIndicatorColor =>
      isLightMode ? textPrimaryColor : const Color(0xFF939393);

  Gradient get tabButtonSelectedIndicatorColor =>
      isLightMode ? getLightGradientSelected() : getDarkGradientSelected();

  Gradient get tabButtonUnSelectedIndicatorColor =>
      isLightMode ? getLightGradientUnSelected() : getDarkGradientUnSelected();

  Color get tabButtonTextSelectedColor =>
      isLightMode ? Colors.white : Colors.black;

  Color get tabButtonTextUnSelectedColor =>
      isLightMode ? accentColor : Colors.white;

  Color get tabButtonTextSelectedBorderColor =>
      isLightMode ? accentColor : Colors.white;

  Color get tabButtonTextUnSelectedBorderColor =>
      isLightMode ? const Color(0x1F7F1417) : const Color(0x29FFFFFF);

  Color get switchSelectedColor => isLightMode ? primaryColor : primaryColor;

  Color get switchUnSelectedColor =>
      isLightMode ? Colors.white : const Color(0xFF272727);

  Color get switchSelectedBorderColor =>
      isLightMode ? primaryColor : primaryColor;

  Color get switchUnSelectedBorderColor =>
      isLightMode ? textFieldBorderColor : const Color(0xFF272727);

  Color get switchTextSelectedColor =>
      isLightMode ? Colors.white : Colors.white;

  Color get switchTextUnSelectedColor =>
      isLightMode ? textSubSecondaryColor : Colors.white;

  Color get markViewBgColor =>
      isLightMode ? const Color(0xFFEEF0F1) : const Color(0x29FFFFFF);

  Color get markViewBorderColor =>
      isLightMode ? const Color(0xFFBFC7CC) : const Color(0xFF939393);

  Color get assessmentSubjectAnalyticsHeaderColor =>
      isLightMode ? const Color(0xFFDCE0E3) : const Color(0x33939393);

  Color get themedPrimaryColor => isLightMode ? accentColor : Colors.white;

  Color get themedTextColor =>
      isLightMode ? const Color(0xFF08263A) : const Color(0xFF939393);

  Color? get deleteIconColor => isLightMode ? accentColor : Colors.white;

  Color? get primaryIconColor => isLightMode ? accentColor : Colors.white;

  Color get underlineColor => isLightMode ? underLineColor : textColor1;

  Color get filterTextColor => isLightMode ? gray75Color : Colors.white;

  Color get filterBackground =>
      isLightMode ? const Color(0xFFF8F3F3) : const Color(0x33939393);

  Color get filterBorderColor =>
      isLightMode ? const Color(0xFFE5D0D1) : const Color(0x29FFFFFF);

  Color get chipBackgroundColor =>
      isLightMode ? const Color(0xFFEEF0F1) : const Color(0x33939393);

  Color get gray7DTextColor =>
      isLightMode ? const Color(0xFF5C707D) : const Color(0xFF939393);
  var temp = const Color(0x42695c5c);

  Gradient get messageBgSenderColor => isLightMode
      ? getLightMessageSenderGradient()
      : getDarkMessageSenderGradient();

  Color get messageContentSenderColor =>
      isLightMode ? themeOf().textPrimaryColor : Colors.white;

  Gradient get messageBgReceiverColor => isLightMode
      ? getLightMessageReceiverGradient()
      : getDarkMessageReceiverGradient();

  Color get messageContentReceiverColor => themeOf().textPrimaryColor;

  Color get gray75TextColor => isLightMode ? gray75Color : Colors.white;

  Color get grayDATextColor =>
      isLightMode ? const Color(0xFFEAD9DA) : const Color(0x29FFFFFF);

  Color get grayE6TextColor =>
      isLightMode ? const Color(0xFFDFE3E6) : const Color(0x33939393);

  Color? get htmlTextColor =>
      isLightMode ? null : Colors.white; //const Color(0xFF939393);

  Color? get htmlTextBackgroundColor =>
      isLightMode ? null : const Color(0xFF121212);

  Color? get notificationBadgeColor =>
      isLightMode ? Color(0xFF3587db) : Colors.white;

  Color? get notificationBadgeTextColor =>
      isLightMode ? Colors.white : const Color(0xFF939393);

  Color? getSkeletonColor() => isLightMode ? Colors.grey[400] : Colors.grey[400];
}

AppTheme themeOf({BuildContext? context}) {
  return BlocProvider.of<AppTheme>(context ?? globalContext);
}
