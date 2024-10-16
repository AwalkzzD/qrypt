import 'package:flutter/material.dart';
import 'package:qrypt/base/src_bloc.dart';
import 'package:qrypt/base/widgets/custom_page_route.dart';
import 'package:qrypt/screens/language/language_screen_bloc.dart';

class LanguageScreen extends BasePage<LanguageScreenBloc> {
  const LanguageScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState()  => _LanguageScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const LanguageScreen());
  }
}

class _LanguageScreenState extends BasePageState<LanguageScreen, LanguageScreenBloc> {

  final LanguageScreenBloc _bloc = LanguageScreenBloc();

  @override
  Widget buildWidget(BuildContext context) {
    return Container();
  }

  @override
  LanguageScreenBloc getBloc() => _bloc;
}
