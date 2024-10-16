import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:qrypt/app_bloc.dart';
import 'package:qrypt/base/theme/app_theme.dart';
import 'package:qrypt/base/widgets/progress_view.dart';

import 'constants/app_widgets.dart';
import 'src_bloc.dart';
import 'src_components.dart';

abstract class BasePage<T extends BasePageBloc?> extends StatefulWidget {
  const BasePage({Key? key, this.bloc}) : super(key: key);

  final BasePageBloc? bloc;

  @override
  BasePageState createState() => getState();

  BasePageState getState();
}

abstract class BasePageState<T extends BasePage, B extends BasePageBloc>
    extends State<T> with WidgetsBindingObserver {
  final bool _isPaused = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  ThemeData? themeData;

  State get state => this;

  Widget buildWidget(BuildContext context);

  B getBloc();

  AppBloc? appBloc;
  AppTheme? appTheme;

  AppBloc? getAppBloc({BuildContext? context}) {
    appBloc ??= BlocProvider.of<AppBloc>(context ?? globalContext);
    return appBloc;
  }

  AppTheme? getAppTheme({BuildContext? context}) {
    appTheme ??= BlocProvider.of<AppTheme>(context ?? globalContext);
    return appTheme;
  }

  void showRefreshIndicator() {
    _refreshKey.currentState?.show();
  }

  bool isDrawerOpen() {
    return _scaffoldKey.currentState?.isDrawerOpen ?? false;
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  @override
  void initState() {
    super.initState();
    getBloc();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });

    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (!getBloc().isKeyboardVisible.isClosed) {
        getBloc().isKeyboardVisible.add(visible);
      }
    });
  }

  ThemeData? getThemeData() {
    return themeData;
  }

  /// Implement your code here
  void onResume() {
    // Implement your code here
  }

  /// Implement your code here
  void onReady() {
    // Implement your code here
  }

  /// Implement your code here
  void onPause() {
    // Implement your code here
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (!_isPaused) {
        onPause();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!_isPaused) {
        onResume();
      }
    }
  }

  bool canPop() => false;

  bool customBackPressed() => false;

  bool enableBackPressed() => true;

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return BlocProvider<B>(
        initBloc: getBloc(),
        child: enableBackPressed()
            ? PopScope(
                canPop: canPop(),
                onPopInvoked: (didPop) => onBackPressed(didPop, context),
                child: getCustomScaffold())
            : getCustomScaffold());
  }

  SystemUiOverlayStyle getSystemUIOverlayStyle() {
    return themeOf().uiOverlayStyleCommon();
  }

  Widget getCustomScaffold() {
    if (isRemoveScaffold()) {
      return getBaseView(context);
    } else {
      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: getSystemUIOverlayStyle(), child: getScaffold());
    }
  }

  bool isResizeToAvoidBottomInset() {
    return true;
  }

  Scaffold getScaffold() {
    return Scaffold(
      resizeToAvoidBottomInset: isResizeToAvoidBottomInset(),
      backgroundColor: scaffoldColor(),
      key: _scaffoldKey,
      appBar: getAppBar() as PreferredSizeWidget?,
      body: getBaseView(context),
      drawer: getDrawer(),
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: getBottomNavigationBar(),
      bottomSheet: getBottomSheet(),
    );
  }

  Color scaffoldColor() {
    return themeOf().scaffoldColor;
  }

  Color progressColor() {
    return themeOf().accentColor;
  }

  Color errorTextColor() {
    return themeOf().textPrimaryColor;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool isRemoveScaffold() => false;

  Future<void> onRefresh() {
    return Future.value(null);
  }

  bool isRefreshEnable() => false;

  Widget getBaseStackView() {
    return buildBaseStateView(buildWidget(context));
  }

  Widget buildBaseStateView(Widget child) {
    return StreamBuilder<int>(
        stream: getBloc().placeHolderStatusStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data == 0) {
              return child;
            } else if (snapshot.data == 1) {
              return getBaseLoadingWidget();
            } else if (snapshot.data == 2) {
              return getBaseEmptyWidget();
            } else if (snapshot.data == 3) {
              return getBaseErrorWidget();
            } else {
              return child;
            }
          } else {
            return Container();
          }
        });
  }

  Widget? customBaseView(BuildContext context) {
    return null;
  }

  Widget baseRefreshIndicator(Widget child) {
    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: onRefresh,
      child: child,
    );
  }

  Widget getBaseView(BuildContext context) {
    return customBaseView(context) ??
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: isRefreshEnable()
              ? baseRefreshIndicator(getBaseStackView())
              : getBaseStackView(),
        );
  }

  Widget getBaseErrorWidget() {
    return QuickView.error(
      title: getBloc().errorView.title,
      onRetry: getBloc().errorView.onRetry,
      textColor: errorTextColor(),
    );
  }

  Widget getBaseLoadingWidget() {
    return const Center(child: ProgressView());
  }

  Widget getBaseEmptyWidget() {
    return QuickView.empty(
      title: getBloc().emptyView.title,
      textColor: errorTextColor(),
    );
  }

  Widget? getBottomNavigationBar() {
    return null;
  }

  Widget? getBottomSheet() {
    return null;
  }

  Widget? getDrawer() {
    return null;
  }

  Widget? buildFloatingActionButton() {
    return null;
  }

  Widget? getAppBar() {
    return null;
  }

  void hideSoftInput() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onBackPressed(bool didPop, BuildContext context) {
    if (!customBackPressed()) {
      if (!didPop) {
        final navigator = Navigator.of(context);
        bool value = isAppWrapperLoading();
        if (!value) {
          navigator.pop();
          hideSoftInput();
        }
      }
    }
  }
}
