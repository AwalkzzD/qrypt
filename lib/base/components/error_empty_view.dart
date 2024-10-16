
import 'package:flutter/material.dart';
import 'package:qrypt/base/components/screen_utils/flutter_screenutil.dart';
import 'package:qrypt/base/widgets/image_view.dart';

import '../src_constants.dart';
import '../theme/app_theme.dart';
import '../utils/common_utils.dart';

enum _QuickViewType { error, empty }

/// A [QuickView] widget that provides out-of-the-box implementation
/// for quick and simple use cases.
class QuickView extends StatelessWidget {
  final _QuickViewType? type;
  final String? title;
  final Function()? onRetry;
  final Color? textColor;
  final double? textSize;

  const QuickView._(
      {this.type, this.title, this.onRetry, this.textColor, this.textSize});

  factory QuickView.error(
      {String? title,
      Function()? onRetry,
      String? retryText,
      Color? textColor,
      double? textSize}) {
    return QuickView._(
      type: _QuickViewType.error,
      title: title,
      onRetry: onRetry,
      textColor: textColor,
      textSize: textSize,
    );
  }

  factory QuickView.empty({String? title, Color? textColor, double? textSize}) {
    return QuickView._(
      type: _QuickViewType.empty,
      title: title,
      textColor: textColor,
      textSize: textSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final e = (type == _QuickViewType.empty)
        ? ImageView(
        height: 100.h,
        width: 100.h,
        image: AppImages.icEmptyView,
        color: themeOf().iconColor,
        imageType: ImageType.svg)
        : Container();

    final t = title == null
        ? Container()
        : Padding(
      padding: EdgeInsetsDirectional.fromSTEB(12.h, 12.h, 12.h, 12.h),
            child: Center(
              child: Text(title!,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: styleMedium2.copyWith(color: textColor),
                  textAlign: TextAlign.center),
            ),
          );

    final r = onRetry == null ? Container() : button();

    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsetsDirectional.all(16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    e,
                    t,
                    SizedBox(height: 8.h),
                    r,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget button() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: themeOf().accentColor,
        shadowColor: themeOf().accentColor,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      onPressed: onRetry,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: 12.h, horizontal: 32.h),
        child: Text(
          string("common_labels.label_retry"),
          maxLines: 1,
          style: styleMedium1.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class QuickCustomView extends StatelessWidget {
  final _QuickViewType? type;
  final String? title;
  final Function()? onRetry;
  final Color? textColor;
  final double? textSize;

  const QuickCustomView._(
      {this.type, this.title, this.onRetry, this.textColor, this.textSize});

  factory QuickCustomView.error(
      {String? title,
      Function()? onRetry,
      String? retryText,
      Color? textColor,
      double? textSize}) {
    return QuickCustomView._(
      type: _QuickViewType.error,
      title: title,
      onRetry: onRetry,
      textColor: textColor,
      textSize: textSize,
    );
  }

  factory QuickCustomView.empty(
      {String? title, Color? textColor, double? textSize}) {
    return QuickCustomView._(
      type: _QuickViewType.empty,
      title: title,
      textColor: textColor,
      textSize: textSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = title == null
        ? Container()
        : Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.h, 0, 12.h, 12.h),
            child: Center(
              child: Text(title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: textSize ?? 18.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: fontFamilyPoppins,
                      color: textColor),
                  textAlign: TextAlign.center),
            ),
          );
    final r = onRetry == null ? Container() : button();

    return Container(
      padding: EdgeInsetsDirectional.all(16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          t,
          SizedBox(height: 8.h),
          r,
        ],
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: themeOf().accentColor,
        shadowColor: themeOf().accentColor,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      onPressed: onRetry,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: 12.h, horizontal: 32.h),
        child: Text(
          string("common_labels.label_retry"),
          maxLines: 1,
          style: styleMedium1.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class PlaceHolderView {
  final String? title;
  final Function()? onRetry;

  PlaceHolderView({this.title = "", this.onRetry});
}
