
import 'package:flutter/cupertino.dart';
import 'package:qrypt/base/components/screen_utils/flutter_screenutil.dart';
import 'package:qrypt/base/constants/app_images.dart';
import 'package:qrypt/base/theme/app_theme.dart';
import 'package:qrypt/base/widgets/image_view.dart';

import '../../constants/app_styles.dart';

Widget getEmptyWidget(String? title) {
  final e = ImageView(
      height: 100.h,
      width: 100.h,
      image: AppImages.icEmptyView,
      imageType: ImageType.svg);

  final t = title == null
      ? Container()
      : Padding(
          padding: EdgeInsets.all(16.h),
          child: Center(
            child: Text(title,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: styleMedium2.copyWith(
                    color: themeOf().textPrimaryColor),
                textAlign: TextAlign.center),
          ),
        );

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [e, t],
  );
}
