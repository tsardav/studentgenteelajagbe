// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
        'REQUEST[${options.method}] => PATH: ${options.uri} =>DATA : ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR RESPONSE [$err] => PATH: ${err.requestOptions.uri}');

    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}');
    return super.onError(err, handler);
  }
}
