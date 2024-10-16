import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/constants/app_widgets.dart';
import '../../base/src_bloc.dart';
import '../../base/theme/app_theme.dart';
import '../../base/widgets/image_view.dart';
import 'splash_screen_bloc.dart';

class SplashScreen extends BasePage<SplashScreenBloc> {
  static const routeName = "/Splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  BasePageState<SplashScreen, SplashScreenBloc> getState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends BasePageState<SplashScreen, SplashScreenBloc> {
  final SplashScreenBloc _bloc = SplashScreenBloc();

  @override
  SystemUiOverlayStyle getSystemUIOverlayStyle() {
    return themeOf().uiOverlayStyleDrawer();
  }

  @override
  SplashScreenBloc getBloc() {
    return _bloc;
  }

  @override
  Color scaffoldColor() {
    return primaryColor;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      color: primaryColor,
      alignment: Alignment.center,
      /// uncomment logo once ready, for now keep text as splash logo
      child: Text('QRYPT', style: fs38BNRegular),
      // child: const ImageView(
      //   height: 140,
      //   width: 140,
      //   image: AppImages.splashLogo,
      //   imageType: ImageType.asset,
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    precacheImage(Image.asset(AppImages.splashLogo).image, globalContext);
    // _delayedNavigation(route)
  }

  void _delayedNavigation(Route route) async {
    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(globalContext, route);
    });
  }
}
