import 'dart:convert';

import 'package:qrypt/base/utils/sp_util.dart';

const String keyScaleFactor = "scaleFactor";
const String keyThemeMode = "theme";
const String keyAppThemeMode = "appTheme";
const String keyTerminologies = "terminologies";
const String keyLangCode = "language";

const String keyLogin = "login";
const String keyAccessToken = "accessToken";
const String keyIdToken = "idToken";
const String keyRefreshToken = "refreshToken";
const String keyExpiration = "expiration";

const String keyFirebaseToken = "setFirebaseToken";

const String keyRequestProperties = "requestProperties";
const String keyMenu = "menu";
const String keyMobileMenu = "mobile_menu";
const String keyUser = "user";
const String keyInstitute = "institute";
const String keyAcademicPeriod = "academicPeriod";
const String keyAcademicPeriodList = "academicPeriodList";
const String keyStudentList = "studentList";
const String keyStudent = "student";
const String keyAuthenticationRequired = "authenticationRequired";
const String keyCalendarViewType = "calendarViewType";
const String keyDashboardElements = "dashboardElements";
const String keyCalendarTimeslot = "calender_timeslot";
const String keyNameSetting = "name_setting";
const String keyDefaultLanguageSetting = "default_language_setting";
const String keyFirstTimeInstall = "firstTimeInstall";

Future<void> sharedPrefClear() async {
  bool? darkModeValue = getThemeMode();
  int? appDarkModeValue = getAppThemeMode();
  double scaleFactorValue = getScaleFactor();
  bool firstTimeInstallValue = getFirstTimeInstall();
  await SpUtil.clear();
  setThemeMode(darkModeValue);
  setAppThemeMode(appDarkModeValue);
  setScaleFactor(scaleFactorValue);
  setFirstTimeInstall(firstTimeInstallValue);
}

/// First Time Install
void setFirstTimeInstall(bool flag) {
  SpUtil.putBool(keyFirstTimeInstall, flag);
}

bool getFirstTimeInstall() {
  return SpUtil.getBool(keyFirstTimeInstall, defValue: true);
}

/// Firebase Token
void setFirebaseToken(String? token) {
  SpUtil.putString(keyFirebaseToken, token);
}

String getFirebaseToken() {
  return SpUtil.getString(keyFirebaseToken);
}

/// Scale Factor
void setScaleFactor(double value) {
  SpUtil.putDouble(keyScaleFactor, value);
}

double getScaleFactor() {
  return SpUtil.getDouble(keyScaleFactor, defValue: 1.0);
}

double getScaleFactorHeight() {
  var scale = SpUtil.getDouble(keyScaleFactor, defValue: 1.0);
  return (scale < 1.0) ? 1.0 : scale;
}

/// Theme
void setThemeMode(bool isDark) {
  SpUtil.putBool(keyThemeMode, isDark);
}

bool getThemeMode() {
  return SpUtil.getBool(keyThemeMode, defValue: false);
}

/// App Theme
void setAppThemeMode(int? themeMode) {
  SpUtil.putInt(keyAppThemeMode, themeMode ?? 0);
}

int getAppThemeMode() {
  return SpUtil.getInt(keyAppThemeMode, defValue: 0);
}

/// authenticationRequired
void setAuthenticationRequired(bool value) {
  SpUtil.putBool(keyAuthenticationRequired, value);
}

bool getAuthenticationRequired() {
  return SpUtil.getBool(keyAuthenticationRequired, defValue: false);
}

/// Login
void setLogin(bool flag) {
  SpUtil.putBool(keyLogin, flag);
}

bool isLogin() {
  return SpUtil.getBool(keyLogin);
}

/// Access Token
void saveAccessToken(String? token) {
  SpUtil.putString(keyAccessToken, token);
}

String getAccessToken() {
  return SpUtil.getString(keyAccessToken);
}

/// Id Token
void saveIdToken(String? token) {
  SpUtil.putString(keyIdToken, token);
}

String getIdToken() {
  return SpUtil.getString(keyIdToken);
}

/// Refresh Token
void saveRefreshToken(String? token) {
  SpUtil.putString(keyRefreshToken, token);
}

String getRefreshToken() {
  return SpUtil.getString(keyRefreshToken);
}

/// ExpiryToken Time
void saveExpiryTokenTime(DateTime? dateTime) {
  if (dateTime != null) {
    SpUtil.putString(keyExpiration, dateTime.toString());
  } else {
    SpUtil.putString(keyExpiration, "");
  }
}

DateTime getExpiryTokenTime() {
  return DateTime.parse(SpUtil.getString(keyExpiration));
}

/// Language
void saveLanguage(String? code) {
  SpUtil.putString(keyLangCode, code);
}

String getLanguage() {
  return SpUtil.getString(keyLangCode, defValue: "en-GB");
}

/// Default Language Setting
void setDefaultLanguageSetting(String? lang) {
  SpUtil.putString(keyDefaultLanguageSetting, lang);
}

String getDefaultLanguageSetting() {
  return SpUtil.getString(keyDefaultLanguageSetting);
}
