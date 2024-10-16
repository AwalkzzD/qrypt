
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

  bool lightMode() => !getThemeMode();

  SystemUiOverlayStyle uiOverlayStyleCommon() {
    if (lightMode()) {
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
    if (lightMode()) {
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
      lightMode() ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;


  /// imp colors (add other if found any)
  ///
  /// Color(0xFF64B6AC) - cyan / primary
  /// Color(0xFF577187) - card color
  /// Color(0xFF577187) - dark theme scaffold (bg)

  Color get primaryColor => const Color(0xFF64B6AC);

  Color get accentColor => const Color(0xFF577187);

  Color get scaffoldColor =>
      lightMode() ? Colors.white : const Color(0xFF293241);

  // add & update required colors and remove unnecessary ones
  // add light - dark colors for text field bgs, bottom bar color, icon color, button bg color etc

  Color get dividerColor =>
      lightMode() ? const Color(0xFFB7B0C6) : const Color(0x4C939393);

  Color get appBarColor => lightMode() ? Colors.white : const Color(0xFF1F1F1F);

  Color get appBarTextColor => lightMode() ? accentColor : Colors.white;

  Color get progressBgColor =>
      lightMode() ? Colors.white : const Color(0xFF1F1F1F);


  Color get bottomBarColor =>
      lightMode() ? Colors.white : const Color(0xFF1F1F1F);

  Color get bottomBarShadowColor =>
      lightMode() ? const Color(0x1A08263A) : const Color(0x1A08263A);

  Color get dialogBgColor =>
      lightMode() ? Colors.white : const Color(0xFF1F1F1F);

  Color get dropShadowColor =>
      lightMode() ? const Color(0xFFECEEF0) : const Color(0x1A08263A);

  Color get lightAccentColor1 => const Color(0x577F1417);

  Color get lightAccentColor2 => const Color(0x1A7F1417);

  Color get borderColor =>
      lightMode() ? const Color(0x2E08263A) : const Color(0x29FFFFFF);

  Color get orangeColor => const Color(0xFFF8A44C);

  Color? get iconSelectedBottomBarColor => lightMode() ? null : Colors.white;

  Color? get iconUnSelectedBottomBarColor =>
      lightMode() ? null : const Color(0x29FFFFFF);

  Color? get iconColor => lightMode() ? null : Colors.white;

  Color get fieldBorderColor =>
      lightMode() ? const Color(0x337F1417) : Colors.black.withOpacity(0.7);

  Color get fieldBgColor =>
      lightMode() ? const Color(0x0D7F1417) : const Color(0xFF272727);

  Color get textFieldHeaderColor =>
      lightMode() ? accentColor : const Color(0xFF939393);

  Color get textFieldHintColor =>
      lightMode() ? textSecondaryColor : const Color(0x808D8D8D);

  Color get textFieldBorderColor =>
      lightMode() ? const Color(0x1F08263A) : const Color(0x4C939393);

  Color get textFieldBgColor =>
      lightMode() ? Colors.white : const Color(0xFF272727);

  Color get dropdownBorderColor =>
      lightMode() ? const Color(0x1F08263A) : const Color(0x4C939393);

  Color get dropdownBgColor =>
      lightMode() ? Colors.white : const Color(0xFF272727);

  Color get dropdownHintColor =>
      lightMode() ? textSecondaryColor : const Color(0x808D8D8D);

  Color get cardBgColor => lightMode() ? Colors.white : const Color(0x33939393);

  Color get cardDropShadowColor =>
      lightMode() ? const Color(0x1408263A) : Colors.transparent;

  Color get stepperLineColor =>
      lightMode() ? const Color(0x2E08263A) : const Color(0x33939393);

  Color get cardBorderColor =>
      lightMode() ? const Color(0x2E08263A) : const Color(0x29FFFFFF);

  Color get cardHighlightBgColor =>
      lightMode() ? const Color(0x0F08263A) : const Color(0xFF272727);

  Color get textPrimaryColor =>
      lightMode() ? const Color(0xFF08263A) : const Color(0xFF939393);

  Color get textPrimaryHeader =>
      lightMode() ? accentColor : const Color(0xFF939393);

  Color get textSecondaryColor =>
      lightMode() ? const Color(0xB208263A) : const Color(0xFF939393);

  Color get qrCodeBorderColor =>
      lightMode() ? border26B : const Color(0xFF939393);

  Color get textSubSecondaryColor =>
      lightMode() ? const Color(0xFF8D8D8D) : Colors.white;

  Color get textHintColor => const Color(0xFF8D8D8D).withOpacity(0.5);

  Color get textAccentColor => lightMode() ? accentColor : Colors.white;

  Color get textColor1 => const Color(0xFF5A5A5A);

  Color get hintTextColor => const Color(0x808D8D8D);

  Color get disableTextColor =>
      lightMode() ? const Color(0xB208263A) : textSecondaryColor;

  Color get grey1Color => const Color(0xFF8D8D8D);

  Color get grey2Color => const Color(0x1208263A);

  Color get activeSwitchBorderBgColor =>
      lightMode() ? accentColor : const Color(0xFF939393);

  Color get inActiveSwitchBorderBgColor =>
      lightMode() ? const Color(0xA808263A) : const Color(0x29FFFFFF);

  Color get activeSwitchBgColor =>
      lightMode() ? const Color(0xFFF3E3E3) : const Color(0x1F08263A);

  Color get inActiveSwitchBgColor =>
      lightMode() ? const Color(0x1F08263A) : Colors.black.withOpacity(0.4);

  Color get activeSwitchToggleColor =>
      lightMode() ? primaryColor : const Color(0xFF939393);

  Color get inActiveSwitchToggleColor =>
      lightMode() ? const Color(0xFF082539) : const Color(0x29FFFFFF);

  Color get tabSelectedIndicatorColor =>
      lightMode() ? accentColor : Colors.white;

  Color get tabUnSelectedIndicatorColor =>
      lightMode() ? textPrimaryColor : const Color(0xFF939393);

  Gradient get tabButtonSelectedIndicatorColor =>
      lightMode() ? getLightGradientSelected() : getDarkGradientSelected();

  Gradient get tabButtonUnSelectedIndicatorColor =>
      lightMode() ? getLightGradientUnSelected() : getDarkGradientUnSelected();

  Color get tabButtonTextSelectedColor =>
      lightMode() ? Colors.white : Colors.black;

  Color get tabButtonTextUnSelectedColor =>
      lightMode() ? accentColor : Colors.white;

  Color get tabButtonTextSelectedBorderColor =>
      lightMode() ? accentColor : Colors.white;

  Color get tabButtonTextUnSelectedBorderColor =>
      lightMode() ? const Color(0x1F7F1417) : const Color(0x29FFFFFF);

  Color get switchSelectedColor => lightMode() ? primaryColor : primaryColor;

  Color get switchUnSelectedColor =>
      lightMode() ? Colors.white : const Color(0xFF272727);

  Color get switchSelectedBorderColor =>
      lightMode() ? primaryColor : primaryColor;

  Color get switchUnSelectedBorderColor =>
      lightMode() ? textFieldBorderColor : const Color(0xFF272727);

  Color get switchTextSelectedColor =>
      lightMode() ? Colors.white : Colors.white;

  Color get switchTextUnSelectedColor =>
      lightMode() ? textSubSecondaryColor : Colors.white;

  Color get markViewBgColor =>
      lightMode() ? const Color(0xFFEEF0F1) : const Color(0x29FFFFFF);

  Color get markViewBorderColor =>
      lightMode() ? const Color(0xFFBFC7CC) : const Color(0xFF939393);

  Color get assessmentSubjectAnalyticsHeaderColor =>
      lightMode() ? const Color(0xFFDCE0E3) : const Color(0x33939393);

  Color get themedPrimaryColor => lightMode() ? accentColor : Colors.white;

  Color get themedTextColor =>
      lightMode() ? const Color(0xFF08263A) : const Color(0xFF939393);

  Color? get deleteIconColor => lightMode() ? accentColor : Colors.white;

  Color? get primaryIconColor => lightMode() ? accentColor : Colors.white;

  Color get underlineColor => lightMode() ? underLineColor : textColor1;

  Color get filterTextColor => lightMode() ? gray75Color : Colors.white;

  Color get filterBackground =>
      lightMode() ? const Color(0xFFF8F3F3) : const Color(0x33939393);

  Color get filterBorderColor =>
      lightMode() ? const Color(0xFFE5D0D1) : const Color(0x29FFFFFF);

  Color get chipBackgroundColor =>
      lightMode() ? const Color(0xFFEEF0F1) : const Color(0x33939393);

  Color get gray7DTextColor =>
      lightMode() ? const Color(0xFF5C707D) : const Color(0xFF939393);
  var temp = const Color(0x42695c5c);

  Gradient get messageBgSenderColor => lightMode()
      ? getLightMessageSenderGradient()
      : getDarkMessageSenderGradient();

  Color get messageContentSenderColor =>
      lightMode() ? themeOf().textPrimaryColor : Colors.white;

  Gradient get messageBgReceiverColor => lightMode()
      ? getLightMessageReceiverGradient()
      : getDarkMessageReceiverGradient();

  Color get messageContentReceiverColor => themeOf().textPrimaryColor;

  Color get gray75TextColor => lightMode() ? gray75Color : Colors.white;

  Color get grayDATextColor =>
      lightMode() ? const Color(0xFFEAD9DA) : const Color(0x29FFFFFF);

  Color get grayE6TextColor =>
      lightMode() ? const Color(0xFFDFE3E6) : const Color(0x33939393);

  Color? get htmlTextColor =>
      lightMode() ? null : Colors.white; //const Color(0xFF939393);

  Color? get htmlTextBackgroundColor =>
      lightMode() ? null : const Color(0xFF121212);

  Color? get notificationBadgeColor =>
      lightMode() ? Color(0xFF3587db) : Colors.white;

  Color? get notificationBadgeTextColor =>
      lightMode() ? Colors.white : const Color(0xFF939393);

  Color? getSkeletonColor() => lightMode() ? Colors.grey[400] : Colors.grey[400];
}

AppTheme themeOf({BuildContext? context}) {
  return BlocProvider.of<AppTheme>(context ?? globalContext);
}
