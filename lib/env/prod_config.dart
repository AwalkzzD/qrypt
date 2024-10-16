import 'package:qrypt/base/app_constants.dart';
import 'package:qrypt/remote/oauth_dio.dart';

import 'base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => "https://consumerapi.classter.com/";

  @override
  bool get httpLogs => false;

  @override
  OAuth get oauth => OAuth(
      clientId: Constants.clientId,
      clientSecret: Constants.clientSecret,
      tokenUrl: Constants.tokenEndpoint);

}