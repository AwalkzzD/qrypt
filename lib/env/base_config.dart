import '../remote/oauth_dio.dart';

abstract class BaseConfig {
  String get apiHost;
  OAuth get oauth;
  bool get httpLogs;
}