
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:qrypt/base/constants/app_widgets.dart';
import 'package:qrypt/models/language_model.dart';
import 'package:qrypt/utils/shared_pref.dart';

List<LanguageModel> getDefaultLanguageList() {
  return [
    LanguageModel(
      id: 1,
      languageTitle: "English (en-UK)",
      languageCode: "en-GB",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 2,
      languageTitle: "Ελληνικά (el-GR)",
      languageCode: "el-GR",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 3,
      languageTitle: "Deutsch (de-DE)",
      languageCode: "de-DE",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 4,
      languageTitle: "Français (fr-FR)",
      languageCode: "fr-FR",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 5,
      languageTitle: "Español (es-ES)",
      languageCode: "es-ES",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 6,
      languageTitle: "Italiano (it-IT)",
      languageCode: "it-IT",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 7,
      languageTitle: "Slovenščina (sl-SI)",
      languageCode: "sl-SI",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 8,
      languageTitle: "Deutsch (nl-NL)",
      languageCode: "nl-NL",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 9,
      languageTitle: "Português (pt-BR)",
      languageCode: "pt-BR",
      isSelected: false,
      isRTL: false,
    ),
    LanguageModel(
      id: 10,
      languageTitle: "Arabic (ar-SA)",
      languageCode: "ar-SA",
      isSelected: false,
      isRTL: true,
    ),
  ];
}

List<Locale> getSupportedLocales() {
  return [
    const Locale('en', 'GB'),
    const Locale('el', 'GR'),
    const Locale('de', 'DE'),
    const Locale('fr', 'FR'),
    const Locale('es', 'ES'),
    const Locale('it', 'IT'),
    const Locale('sl', 'SI'),
    const Locale('nl', 'NL'),
    const Locale('pt', 'BR'),
    const Locale('ar', 'SA'),
  ];
}

void changeLanguage(String code){
  String defaultLanguage = "en-GB";
  LanguageModel? availableLanguage = getDefaultLanguageList().firstWhereOrNull((element) => element.languageCode == code);
  if(availableLanguage!=null){
    saveLanguage(code);
    globalContext.setLocale(getLanguageLocale(code));
  }else{
    saveLanguage(defaultLanguage);
    globalContext.setLocale(getLanguageLocale(defaultLanguage));
  }
}

Locale getLanguageLocale(String code){
  List<String> codeParts = code.split('-');
  String languageCode = codeParts.isNotEmpty ? codeParts[0] : 'en';
  String countryCode = codeParts.length > 1 ? codeParts[1] : 'GB';
  return Locale(languageCode, countryCode);
}

Locale getDefaultLocale(){
  return const Locale('en', 'GB');
}
