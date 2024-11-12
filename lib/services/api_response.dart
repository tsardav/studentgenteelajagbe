// ignore_for_file: avoid_shadowing_type_parameters, non_constant_identifier_names

// import 'dart:developer';

import 'dart:developer';

abstract class ApiResponse<T> {
  bool get success;
  int get status_code;
  String get message;
  T? get data;
  T? get dataList;
}

class ApiResponseImpl<T> extends ApiResponse<T> {
  final dynamic myData;

  final bool? isList;

  final T Function(dynamic value)? fromJson;

  final T Function(List value)? fromJsonList;

  ApiResponseImpl({this.myData, this.isList, this.fromJson, this.fromJsonList});

  @override
  bool get success => myData.runtimeType == List ? true : false;

  @override
  int get status_code => myData.runtimeType == List ? 200 : 201;

  @override
  String get message => "Success";

  @override
  T? get data => isList == true
      ? null
      : convertMapToModel<T>((map) => fromJson!(map)!, myData);

  @override
  T? get dataList =>
      convertListToModel<T>((map) => fromJsonList!(map)!, myData);

  T convertMapToModel<T>(
      T Function(Map<String, dynamic> map) fromJson, Map response) {
    return fromJson((response).cast());
  }

  T convertListToModel<T>(T Function(List map) fromJson, List data) {
    log("hello: $data");
    return fromJson(data);
  }
}
