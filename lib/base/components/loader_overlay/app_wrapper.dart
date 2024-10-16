
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrypt/base/components/screen_utils/flutter_screenutil.dart';
import 'package:qrypt/base/constants/app_styles.dart';
import 'package:qrypt/base/theme/app_theme.dart';
import 'package:qrypt/base/utils/common_utils.dart';

import '../../src_widgets.dart';

BuildContext? getAppWrapperContext() {
  return _tKey.currentContext;
}

bool isAppWrapperLoading() {
  return _loaderShown;
}

final GlobalKey _tKey = GlobalKey(debugLabel: 'overlay_parent');
final _modalBarrierDefaultColor = Colors.black.withOpacity(0.35);

OverlayEntry? _loaderEntry;

bool isDarkTheme = false;

bool _loaderShown = false;

class AppWrapper extends StatelessWidget {
  final Widget? child;
  final bool darkTheme;

  const AppWrapper({Key? key, this.child, this.darkTheme = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    isDarkTheme = darkTheme;
    return SizedBox(
      key: _tKey,
      child: child,
    );
  }
}

OverlayState? get _overlayState {
  final context = _tKey.currentContext;
  if (context == null) return null;

  NavigatorState? navigator;
  void visitor(Element element) {
    if (navigator != null) return;

    if (element.widget is Navigator) {
      navigator = (element as StatefulElement).state as NavigatorState?;
    } else {
      element.visitChildElements(visitor);
    }
  }

  context.visitChildElements(visitor);

  assert(navigator != null,
      '''Cannot find AppWrapper above the widget tree, unable to show overlay''');
  return navigator!.overlay;
}

Future<void> showLoader(
    {bool isModal = false,
    Color? modalColor,
    String loadingText = "",
    bool modalDismissible = true}) async {
  if(isAppWrapperLoading()){
    return;
  }else{
    try {
      String progressText = "";
      if(loadingText.isEmpty){
        progressText = string("common_labels.label_loading");
      }
      final child = Center(
        child: Container(
          decoration: BoxDecoration(
              color: themeOf().progressBgColor,
              borderRadius: BorderRadius.circular(12)
          ),
          padding: EdgeInsetsDirectional.all(24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ProgressView(),
              Container(
                margin: EdgeInsetsDirectional.only(top: 20.h),
                child: Text(
                  progressText,
                  style: styleMedium1.copyWith(
                      decoration: TextDecoration.none,
                      color: themeOf().textPrimaryColor,
                      fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
        ),
      );
      await _showOverlay(
        child: isModal
            ? Stack(
          children: <Widget>[
            ModalBarrier(
              color: modalColor ?? _modalBarrierDefaultColor,
              dismissible: modalDismissible,
            ),
            child
          ],
        )
            : child,
        type: _OverlayType.Loader,
      );
    } catch (err) {
      rethrow;
    }
  }
}

Future<void> hideLoader() async {
  try {
    await _hideOverlay(_OverlayType.Loader);
  } catch (err) {
    rethrow;
  }
}

/// These methods deal with showing and hiding the overlay
Future<void> _showOverlay({required Widget child, _OverlayType? type}) async {
  try {
    final overlay = _overlayState;

    if (type!.isShowing()) {
      return Future.value(false);
    }
    Widget mainChild = AnnotatedRegion<SystemUiOverlayStyle>(
        value: themeOf().uiOverlayStyleDialog(),
        child: child
    );
    final overlayEntry = OverlayEntry(
      builder: (context) => mainChild,
    );

    overlay!.insert(overlayEntry);
    type.setOverlayEntry(overlayEntry);
    type.setShowing();
  } catch (err) {
    rethrow;
  }
}

Future<void> _hideOverlay(_OverlayType type) async {
  try {
    if (type.isShowing()) {
      type.getOverlayEntry()?.remove();
      type.hide();
    } else {}
  } catch (err) {
    rethrow;
  }
}

enum _OverlayType {
  Loader,
}

extension OverlayTypeExtension on _OverlayType {
  String name() {
    return "Loader";
  }

  bool isShowing() {
    return _loaderShown;
  }

  void setShowing() {
    _loaderShown = true;
  }

  void hide() {
    _loaderShown = false;
  }

  OverlayEntry? getOverlayEntry() {
    return _loaderEntry;
  }

  void setOverlayEntry(OverlayEntry entry) {
    _loaderEntry = entry;
  }
}
