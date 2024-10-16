import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:qrypt/app_bloc.dart';
import 'package:qrypt/base/bloc/base_bloc_provider.dart';
import 'package:qrypt/base/components/screen_utils/flutter_screenutil.dart';
import 'package:qrypt/base/constants/app_themes.dart';
import 'package:qrypt/base/constants/app_widgets.dart';
import 'package:qrypt/base/theme/app_theme.dart';
import 'package:qrypt/base/theme/theme_utils.dart';
import 'package:qrypt/base/utils/localization_json_asset_loader.dart';
import 'package:qrypt/base/utils/locationzation_utils.dart';
import 'package:qrypt/base/utils/sp_util.dart';
import 'package:qrypt/env/environment.dart';
import 'package:qrypt/screens/splash/splash_screen.dart';
import 'package:qrypt/utils/shared_pref.dart';

import 'base/components/loader_overlay/app_wrapper.dart';

/// Main function of the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;

  /// Set Environment
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.PROD,
  );
  Environment().initConfig(environment);

  /// Initialize EasyLocalization for localization
  await EasyLocalization.ensureInitialized();

  /// Initialize shared preferences instance
  await SpUtil.getInstance();

  /// Set preferred orientation to portrait up
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Run the app with BlocProviders for state management
  runApp(
    BlocProvider<AppBloc>(
      initBloc: AppBloc(),
      child: BlocProvider<AppTheme>(
        initBloc: AppTheme(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    var dispatcher = SchedulerBinding.instance.platformDispatcher;
    dispatcher.onPlatformBrightnessChanged = () => setTheme();

    WidgetsBinding.instance.addPostFrameCallback((c) {
      setTheme(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<AppTheme>(context);
    return StreamBuilder<bool>(
        stream: themeBloc.isDarkModeTheme.stream,
        builder: (context, themeSnapshot) {
          return AppWrapper(
            child: LocalizedApp(
              child: StreamBuilder<double>(
                  stream: themeBloc.scaleFactor.stream,
                  builder: (context, scaleSnapshot) {
                    var scaleFactor = scaleSnapshot.data ?? 1.0;
                    return _buildMaterialApp(
                        context, themeSnapshot.data, scaleFactor);
                  }),
            ),
          );
        });
  }

  /// Build MaterialApp widget
  Widget _buildMaterialApp(
      BuildContext context, bool? isDarkMode, double scaleFactor) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: () => MaterialApp(
        builder: (context, child) =>
            _buildScaledMediaQuery(context, scaleFactor, child),
        debugShowCheckedModeBanner: false,
        title: "QRYPT",
        darkTheme: darkTheme(context),
        theme: normalTheme(context),
        themeMode: isDarkMode == true ? ThemeMode.dark : ThemeMode.light,
        home: const SplashScreen(),
        navigatorKey: navigatorKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }

  /// Build MediaQuery with scaled text
  Widget _buildScaledMediaQuery(
      BuildContext context, double scaleFactor, Widget? child) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: TextScaler.linear(scaleFactor)),
      child: child ?? const SizedBox(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Widget for localization using EasyLocalization
class LocalizedApp extends StatelessWidget {
  const LocalizedApp({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: getSupportedLocales(),
      path: 'assets/translations',
      startLocale: getLanguageLocale(getLanguage()),
      assetLoader: const LocalizationJsonAssetLoader(),
      fallbackLocale: const Locale('en', 'GB'),
      useFallbackTranslations: true,
      child: child,
    );
  }
}
