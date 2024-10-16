
import 'package:qrypt/base/network/base/response_data.dart';
import 'package:qrypt/remote/oauth_dio.dart';
import 'package:qrypt/utils/shared_pref.dart';

import '../base/src_api.dart';
import '../env/environment.dart';

Future<ResponseWithData<T>?> get<T>(String url, {params, String? tenant, String? period, String? contentType, Map<String, dynamic>? headers, Options? options, cancelToken}) async {
  options = await authOptions(tenant,period,contentType,headers);
  return CommonAPIManager.getInstance()?.get<T>(url,
      params: params,
      options: options,
      token: cancelToken
  );
}

Future<ResponseWithData<T>?> post<T>(String url, {params, String? tenant, String? period,String? contentType, Map<String, dynamic>? headers, Options? options, cancelToken}) async {
  options = await authOptions(tenant,period,contentType,headers);
  return CommonAPIManager.getInstance()?.post<T>(url, params: params, options: options, token: cancelToken);
}

Future<ResponseWithData<T>?> delete<T>(String url, {params,String? tenant, String? period, String? contentType, Map<String, dynamic>? headers, Options? options, cancelToken}) async {
  options = await authOptions(tenant,period,contentType,headers);
  return CommonAPIManager.getInstance()?.delete<T>(url, params: params, options: options, token: cancelToken);
}

Future<ResponseWithData<T>?> put<T>(String url, {params,String? tenant, String? period, String? contentType, Map<String, dynamic>? headers, Options? options, cancelToken}) async {
  options = await authOptions(tenant,period,contentType,headers);
  return CommonAPIManager.getInstance()?.put<T>(url, params: params, options: options, token: cancelToken);
}

Future<ResponseWithData<T>?> deleteNoContent<T>(String url, {params,String? tenant, String? period, String? contentType, Map<String, dynamic>? headers, Options? options, cancelToken}) async {
  options = await authOptionsNoContent(tenant,period,headers);
  return CommonAPIManager.getInstance()?.delete<T>(url, params: params, options: options, token: cancelToken);
}

Future<Options?> authOptions(String? tenant, String? period, String? contentType, Map<String, dynamic>? additionalHeaders) async {
  Options options = Options(
    headers: {
      'Content-Type' : contentType ?? "application/json",
      'Cookie' : "_culture_main=${getLanguage()}"
    },
    receiveTimeout: const Duration(seconds: HttpCode.TIME_OUT),
    sendTimeout: const Duration(seconds: HttpCode.TIME_OUT),
  );
  if(contentType==null){
    options.headers?["Accept"] = "application/json";
  }

  if(getLanguage().isNotEmpty){
    options.headers?["Accept-Language"] = getLanguage();
  }
  if(additionalHeaders!=null) {
    options.headers?.addAll(additionalHeaders);
  }
  return options;
}

Future<Options?> authOptionsNoContent(String? tenant, String? period, Map<String, dynamic>? additionalHeaders) async {
  Options options = Options(
    headers: {
      'Cookie' : "_culture_main=${getLanguage()}"
    },
    receiveTimeout: const Duration(seconds: HttpCode.TIME_OUT),
    sendTimeout: const Duration(seconds: HttpCode.TIME_OUT),
  );

  if(getLanguage().isNotEmpty){
    options.headers?["Accept-Language"] = getLanguage();
  }
  if(additionalHeaders!=null) {
    options.headers?.addAll(additionalHeaders);
  }
  return options;
}

class CommonAPIManager extends DioManager {
  CommonAPIManager._();

  static CommonAPIManager? _instance;

  static CommonAPIManager? getInstance() {
    _instance ??= CommonAPIManager._();
    return _instance;
  }

  @override
  void configDio(Dio? dio) {
    final oauth = Environment().config?.oauth;
    if(oauth!=null) {
      dio?.interceptors.add(AuthBearerInterceptor(oauth, onInvalid: onAuthError));
    }
    //print("url => ${Environment().config?.apiHost}");
    super.configDio(dio);
  }

  Future<void> onAuthError(Exception error){
    return Future.value(());
  }

  @override
  T decode<T>(response) => response;

  @override
  String getBaseUrl() {
    return "${Environment().config?.apiHost}";
  }

  @override
  bool isSuccess(Response? response) {
    return response?.statusCode == 200 || response?.statusCode == 201 || response?.statusCode == 204;
  }

  @override
  bool isShowLog() => true;

  @override
  void logout() {

  }
}