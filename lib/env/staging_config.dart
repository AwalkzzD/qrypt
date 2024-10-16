
import 'package:qrypt/base/app_constants.dart';
import 'package:qrypt/remote/oauth_dio.dart';

import 'base_config.dart';

class StagingConfig implements BaseConfig {
  @override
  String get apiHost => "https://consumerapi.classter.com/";

  @override
  bool get httpLogs => true;

  @override
  OAuth get oauth => OAuth(
      clientId: Constants.clientId,
      clientSecret: Constants.clientSecret,
      tokenUrl: Constants.tokenEndpoint);

}