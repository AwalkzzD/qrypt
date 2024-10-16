import 'package:dio/dio.dart';

class ResponseWithData<R> {
  final Response? response;
  final R data;

  ResponseWithData(this.response, this.data);
}