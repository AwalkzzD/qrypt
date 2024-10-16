import 'dart:io';



import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qrypt/base/network/constants/net_constants.dart';
import 'package:qrypt/base/utils/common_utils.dart';
import 'package:qrypt/env/environment.dart';

import '../dio_http_formatter.dart';
import '../error/net_exception.dart';
import 'abstract_dio_manager.dart';

/// The dio network request management class implements most of the common logic. The parts that need to be customized according to the project requirements should be implemented in the subclass, and the subclass should be a singleton
abstract class DioManager extends AbstractDioManager {
  ///Unified configuration, used to add a unified header_widgets, please fill in the request for a single add request configuration, a single configuration only affects a single request, and does not affect the unified configuration
  @override
  BaseOptions configBaseOptions() {
    return BaseOptions(
        connectTimeout: const Duration(seconds: HttpCode.TIME_OUT),
        receiveTimeout: const Duration(seconds: HttpCode.TIME_OUT),
        sendTimeout: const Duration(seconds: HttpCode.TIME_OUT),
        baseUrl: getBaseUrl(),
        validateStatus: (status) {
          // Do not use http status code to judge the status, use AdapterInterceptor to handle (applicable to standard REST style)
          return true;
        },
        responseType: ResponseType.plain);
  }

  @override
  void configDio(Dio? dio) {
    if(kDebugMode) {
      dio?.interceptors.add(HttpFormatter());
     //dio?.interceptors.add(dioLoggerInterceptor);
    }
  }

  ///Business logic error mapping, currently not doing translation work, the default error message returned by the server is returned
  @override
  NetWorkException getBusinessErrorResult<T>(int code, String error, T data) {
    if(code==401){
      logout();
      error = "Authentication failed";
    }
    return NetWorkException<T>(code, error, data: data);
  }

  /// HTTP layer network request error translation
  @override
  NetWorkException getHttpErrorResult(DioException e) {
    Response? errorResponse;

    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = Response(
        statusCode: HttpCode.UNKNOWN_NET_ERROR,
        statusMessage: string("api_errors.error_unknown"),
        requestOptions: e.requestOptions,
      );
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        errorResponse?.statusMessage = string("api_errors.error_connection_timeout");
        errorResponse?.statusCode = HttpCode.CONNECT_TIMEOUT;
        break;
      case DioExceptionType.sendTimeout:
        errorResponse?.statusMessage = string("api_errors.error_request_timeout");
        errorResponse?.statusCode = HttpCode.SEND_TIMEOUT;
        break;
      case DioExceptionType.receiveTimeout:
        errorResponse?.statusMessage = string("api_errors.error_response_timeout");
        errorResponse?.statusCode = HttpCode.RECEIVE_TIMEOUT;
        break;
      case DioExceptionType.cancel:
        errorResponse?.statusMessage = string("api_errors.error_request_cancel");
        errorResponse?.statusCode = HttpCode.REQUEST_CANCEL;
        break;
      case DioExceptionType.unknown:
      case DioExceptionType.connectionError:
        dynamic error = e.error;
        if (error is SocketException) {
          errorResponse?.statusCode = HttpCode.NETWORK_ERROR;
          errorResponse?.statusMessage = string("api_errors.error_internet_connection");
        } else if (error is HttpException) {
          errorResponse?.statusCode = HttpCode.UNKNOWN_NET_ERROR;
          errorResponse?.statusMessage = string("api_errors.error_server_connection");
        } else {
          errorResponse?.statusCode = HttpCode.UNKNOWN_NET_ERROR;
          errorResponse?.statusMessage = string("api_errors.error_unknown");
        }
        break;
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 401:
            logout();
            errorResponse?.statusMessage = string("api_errors.error_auth_failed");
            break;
          case 404:
            errorResponse?.statusMessage = string("api_errors.error_page_not_found");
            break;
          case 500:
            errorResponse?.statusMessage = string("api_errors.error_internal_server");
            break;
          default:
            errorResponse?.statusMessage = string("api_errors.error_unknown");
        }
        break;
      default:
        errorResponse?.statusMessage = string("api_errors.error_unknown");
        errorResponse?.statusCode = HttpCode.UNKNOWN_NET_ERROR;
    }
    return NetWorkException(
      errorResponse?.statusCode,
      errorResponse?.statusMessage,
    );
  }

  ///Determine whether the network request is successful
  @override
  bool isSuccess(Response? response) {
    return true;
  }

  ///Whether to display the log log
  bool isShowLog() => Environment().config?.httpLogs ?? false;

  ///Set baseURl
  String getBaseUrl();
}
