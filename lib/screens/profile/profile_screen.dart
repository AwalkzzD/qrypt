import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qrypt/base/components/screen_utils/flutter_screenutil.dart';

import 'package:qrypt/base/constants/app_colors.dart';
import 'package:qrypt/base/constants/app_images.dart';
import 'package:qrypt/base/constants/app_styles.dart';

import 'package:qrypt/base/theme/app_theme.dart';
import 'package:qrypt/base/theme/theme_utils.dart';
import 'package:qrypt/base/utils/common_utils.dart';
import 'package:qrypt/base/widgets/image_view.dart';
import 'package:qrypt/screens/language/language_screen.dart';
import 'package:qrypt/screens/profile/profile_screen_bloc.dart';
import 'package:qrypt/utils/shared_pref.dart';
import 'package:qrypt/utils/widgets/divider_widget.dart';

import '../../base/src_bloc.dart';

class ProfileScreen extends BasePage<ProfileScreenBloc> {
  const ProfileScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends BasePageState<ProfileScreen, ProfileScreenBloc> {
  final ProfileScreenBloc _bloc = ProfileScreenBloc();

  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: [
        settingTile(AppImages.icLanguage, string("settings_screen.label_app_language"), () => Navigator.push(context, LanguageScreen.route())),
        settingThemeSwitchTile(),
      ],
    );
  }

  @override
  ProfileScreenBloc getBloc() => _bloc;

  /// util widgets

  Widget settingTile(String settingIcon, String settingTittle, VoidCallback onClick) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.h, 10.h, 20.h, 10.h),
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(6.h, 6.h, 6.h, 6.h),
          decoration: BoxDecoration(
              color: themeOf().cardBgColor,
              border: Border.all(color: themeOf().cardBorderColor),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.h, 12.h, 12.h, 12.h),
                child: ImageView(
                    height: 20.h,
                    width: 20.h,
                    image: settingIcon,
                    color: themeOf().iconColor,
                    imageType: ImageType.svg),
              ),
              Expanded(
                child: Text(
                  settingTittle,
                  style:
                  styleMedium1.copyWith(color: themeOf().textPrimaryColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget settingThemeSwitchTile() {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.h, 10.h, 20.h, 10.h),
        child: Container(
          padding: EdgeInsetsDirectional.fromSTEB(14.h, 6.h, 10.h, 6.h),
          decoration: BoxDecoration(
              color: themeOf().cardBgColor,
              border: Border.all(color: themeOf().cardBorderColor),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Text(string("settings_screen.label_theme"),
                  style:
                  styleMedium1.copyWith(color: themeOf().textPrimaryColor)),
              DividerWidget(
                  verticalMargin: 5.h, color: themeOf().cardBorderColor),
              SizedBox(height: 10.h),
              Row(children: [
                Expanded(child: buildThemeButton(index: 1)),
                Expanded(child: buildThemeButton(index: 0)),
                Expanded(child: buildThemeButton(index: 2))
              ]),
              SizedBox(height: 6.h),
            ],
          ),
        ));
  }

  Widget buildThemeButton({required int index}) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        setAppThemeMode(index);
        setTheme();
        setState(() {});
      },
      child: Column(
        children: [
          Icon(getIconData(index: index),
              color: getIconColor(index: index),
              size: getIconSize(index: index)),
          Text(
            getThemeName(index: index),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: styleSmall.copyWith(color: themeOf().textPrimaryColor),
          ),
        ],
      ),
    );
  }

  IconData getIconData({required int index}) {
    switch (index) {
      case 0:
        return Icons.settings;
      case 1:
        return Icons.sunny;
      case 2:
        return Icons.nights_stay;
      default:
        return Icons.settings;
    }
  }

  String getThemeName({required int index}) {
    switch (index) {
      case 0:
        return string("theme.label_system_default_mode");
      case 1:
        return string("theme.label_light_mode");
      case 2:
        return string("theme.label_dark_mode");
      default:
        return string("settings_screen.label_theme");
    }
  }

  getIconColor({required int index}) =>
      getAppThemeMode() == index
          ? themeOf().primaryColor
          : isDarkMode()
          ? white
          : themeOf().iconUnSelectedBottomBarColor;

  getIconSize({required int index}) => 32.h;
}
