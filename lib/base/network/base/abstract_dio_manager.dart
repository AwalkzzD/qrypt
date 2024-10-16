import 'dart:convert';
import 'dart:io';


import 'package:qrypt/base/src_api.dart';
import 'package:qrypt/base/utils/common_utils.dart';

import 'response_data.dart';

/// Network request management abstraction layer\
/// Responsible for executing the general logic of network requests
/// The different configurations of different projects are handed over to the upper layer to achieve
abstract class AbstractDioManager {
  //Dio? dio;

  Dio? getDio() {
    Dio? dio = Dio(configBaseOptions());
    configDio(dio);
    return dio;
  }

  AbstractDioManager() {
    /*dio = Dio(configBaseOptions());
    //dio?.options.headers['content-Type'] = 'application/json';
    configDio();*/
  }

  ///get request
  Future<ResponseWithData<T>> get<T>(String url, {params, options, token}) async {
    return requestHttp<T>(
      url,
      Method.GET,
      params: params,
      options: options,
      cancelToken: token,
      decode: decode,
    );
  }

  ///post request
  Future<ResponseWithData<T>> post<T>(String url, {params, options, token}) async {
    return requestHttp<T>(
      url,
      Method.POST,
      params: params,
      options: options,
      cancelToken: token,
      decode: decode,
    );
  }

  Future<ResponseWithData<T>> delete<T>(String url, {params, options, token}) async {
    return requestHttp<T>(
      url,
      Method.DELETE,
      params: params,
      options: options,
      cancelToken: token,
      decode: decode,
    );
  }

  Future<ResponseWithData<T>> put<T>(String url, {params, options, token}) async {
    return requestHttp<T>(
      url,
      Method.PUT,
      params: params,
      options: options,
      cancelToken: token,
      decode: decode,
    );
  }

  Future<ResponseWithData<T>> patch<T>(String url, {params, options, token}) async {
    return requestHttp<T>(
      url,
      Method.PATCH,
      params: params,
      options: options,
      cancelToken: token,
      decode: decode,
    );
  }

  ///R is the return type, T is the data type
  Future<ResponseWithData<R>> requestHttp<R>(
    String url,
    Method method, {
    params,
    options,
    cancelToken,
    required R Function(dynamic json) decode,
  }) async {
    Response? response;
    try {
      if (method == Method.GET) {
        response = await getDio()?.get(url,
            queryParameters: params,
            options: options,
            cancelToken: cancelToken);
      } else if (method == Method.POST) {
        if(params!=null) {
          response = await getDio()?.post(url, data: params, options: options, cancelToken: cancelToken);
        }else{
          response = await getDio()?.post(url, options: options, cancelToken: cancelToken);
        }
      } else if (method == Method.DELETE) {
        response = await getDio()?.delete(url, data: params, options: options, cancelToken: cancelToken);
      } else if (method == Method.PUT) {
        response = await getDio()?.put(url, data: params, options: options, cancelToken: cancelToken);
      } else if (method == Method.PATCH) {
        response = await getDio()?.patch(url, data: params, options: options, cancelToken: cancelToken);
      }
    } on DioException catch (error) {
      throw getHttpErrorResult(error);
    } catch (error) {
      if (error is SocketException) {
        throw NetWorkException(HttpCode.NETWORK_ERROR, string("api_errors.error_internet_connection"));
      }
    }
    dynamic data;
    if (!isSuccess(response)) {
      handleFailed(response, data, decode);
    } else {
      data = handleSuccess(data, decode, response);
    }
    return ResponseWithData(response, data);
  }

  R handleSuccess<R>(data, Function(dynamic json) decode, Response<dynamic>? response) {
    try {
      data = decode(response?.data.toString());
      return data as R;
    } catch (e) {
      throw getBusinessErrorResult(HttpCode.PARSE_JSON_ERROR, "json parse error 0 ~ $e",response);
    }
  }

  handleFailed(Response<dynamic>? response, data, Function(dynamic zjson) decode) {
    if (response?.data is Map) {
      try {
        data = decode(response?.data.toString());
      } catch (e) {
        throw getBusinessErrorResult(HttpCode.PARSE_JSON_ERROR, "json parse error 1 ~ $e",response);
      }
      throw getBusinessErrorResult(getCode(response), getMessage(response),response);
    }else if (response?.data is String) {
      throw getBusinessErrorResult(getCode(response), response?.data,response);
    } else {
      throw getBusinessErrorResult(getCode(response), getMessage(response),response);
    }
  }

  ///The upper level realization of the specific analysis logic
  T decode<T>(dynamic response);

  NetWorkException getBusinessErrorResult<T>(int code, String error, T data);

  NetWorkException getHttpErrorResult(DioException e);

  ///Initialize dio parameters
  BaseOptions configBaseOptions();

  ///Judge the success or failure of the business layer's return, report an error after failure, and perform data analysis after success
  bool isSuccess(Response? response);

  ///The default is "code" to get the response code. If the key of the code returned by the server request is different, please rewrite this method
  int getCode(Response? response) {
    return response?.statusCode ?? 1212;
    Map<String, dynamic> data = jsonDecode(response!.data.toString());
    return data["success"] == true ? 200 : response.statusCode ?? 1212;
  }

  ///The default is "message" to get the response message. If the key of the message returned by the server request is different, please override this method
  String getMessage(Response? response) {
    return "";
    Map<String, dynamic> data = jsonDecode(response!.data.toString());
    return data["message"];
  }

  ///dio configuration work, add interceptors and other operations
  void configDio(Dio? dio);

  ///Token invalid logout logic
  void logout();
}
