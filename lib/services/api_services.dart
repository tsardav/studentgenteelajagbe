import 'package:student/utils/utils.dart';

enum MethodType {
  post,
  get,
  patch,
  put,
  delete,
}

class ApiServices {
  final DioClient dioClient = DioClient();

  Future<Either<Failure, ApiResponseImpl<List<Student>>>> fetchStudent() async {
    try {
      final response = await dioClient.request(
        type: MethodType.get,
        url: ApiEndpoints.fetchStudent,
      );
      // log("response: ${response.data}");
      return switch (response.statusCode) {
        201 || 200 => Right(
            ApiResponseImpl(
                myData: jsonDecode(response.data),
                isList: true,
                fromJsonList: (e) {
                  return e.map((item) => Student.fromJson(item)).toList();
                }),
          ),
        _ => Left(
            ValidationFailure(errorMessageHandler("Something went wrong")),
          )
      };
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    }
  }

  Future<Either<Failure, ApiResponseImpl<String>>> delete(
      {required int studentId}) async {
    try {
      final response = await dioClient.request(
        type: MethodType.delete,
        url: "${ApiEndpoints.fetchStudent}/$studentId",
      );
      return switch (response.statusCode) {
        201 || 200 => Right(ApiResponseImpl(
            myData: jsonDecode(response.data),
            isList: null,
            fromJson: (e) => "Success",
          )),
        _ => Left(ValidationFailure(errorMessageHandler("")))
      };
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    }
  }

  Future<Either<Failure, ApiResponseImpl<Student>>> createStudent(
      {required Student student}) async {
    try {
      final response = await dioClient.request(
          type: MethodType.post,
          url: ApiEndpoints.fetchStudent,
          body: student.toJson());
      log("create user: ${response.data}");
      return switch (response.statusCode) {
        201 || 200 => Right(ApiResponseImpl(
            myData: jsonDecode(response.data),
            isList: null,
            fromJson: (e) => Student.fromJson(e),
          )),
        _ => Left(ValidationFailure(errorMessageHandler("")))
      };
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    }
  }

  // Future<Either<Failure, ApiResponseImpl<String>>> validateUsername(
  //     {required String username}) async {
  //   try {
  //     final response = await dioClient.request(
  //         type: MethodType.get,
  //         url: ApiEndpoints.validateUsername,
  //         body: null,
  //         queryParams: {"username": username});
  //     return switch (response.statusCode) {
  //       201 || 200 => right(ApiResponseImpl(
  //           myData: jsonDecode(response.data),
  //           isList: null,
  //           fromJson: (e) {
  //             return e['data'];
  //           })),
  //       _ => left(ValidationFailure(
  //           errorMessageHandler(jsonDecode(response.data)['data'])))
  //     };
  //   } on DioException catch (e) {
  //     return left(_handleDioError(e));
  //   }
  // }

  // Future<Either<Failure, ApiResponseImpl<String>>> setUsername(
  //     {required String username}) async {
  //   try {
  //     final response = await dioClient.request(
  //       type: MethodType.patch,
  //       url: ApiEndpoints.setUsername,
  //       body: {"username": username},
  //     );
  //     return switch (response.statusCode) {
  //       201 || 200 => right(ApiResponseImpl(
  //           myData: jsonDecode(response.data),
  //           isList: null,
  //           fromJson: (e) {
  //             return "";
  //           })),
  //       204 => right(ApiResponseImpl(
  //           myData: {},
  //           isList: null,
  //           fromJson: (e) {
  //             return "";
  //           })),
  //       _ => left(ValidationFailure(
  //           errorMessageHandler(jsonDecode(response.data)['data'])))
  //     };
  //   } on DioException catch (e) {
  //     return left(_handleDioError(e));
  //   }
  // }

  // Future<Either<Failure, ApiResponseImpl<String>>> updateLocation(
  //     {required int cityId, required int countryId}) async {
  //   try {
  //     final response = await dioClient.request(
  //       type: MethodType.patch,
  //       url: ApiEndpoints.updateLocation,
  //       body: {
  //         "city_id": cityId,
  //         "country_id": countryId,
  //       },
  //     );
  //     return switch (response.statusCode) {
  //       201 || 200 => right(ApiResponseImpl(
  //           myData: jsonDecode(response.data),
  //           isList: null,
  //           fromJson: (e) {
  //             return "";
  //           })),
  //       204 => right(ApiResponseImpl(
  //           myData: {},
  //           isList: null,
  //           fromJson: (e) {
  //             return "";
  //           })),
  //       _ => left(ValidationFailure(
  //           errorMessageHandler(jsonDecode(response.data)['data'])))
  //     };
  //   } on DioException catch (e) {
  //     return left(_handleDioError(e));
  //   }
  // }

  // Future<Either<Failure, ApiResponseImpl<String>>> setServiceSkill(
  //     {required AuthData data}) async {
  //   try {
  //     final response = await dioClient.request(
  //       type: MethodType.post,
  //       url: ApiEndpoints.setService,
  //       body: {
  //         "service_name": data.serviceName,
  //         "is_remote_working": data.isRemoteWorking,
  //       },
  //     );
  //     return switch (response.statusCode) {
  //       201 || 200 => right(ApiResponseImpl(
  //           myData: jsonDecode(response.data),
  //           isList: null,
  //           fromJson: (e) {
  //             return "";
  //           })),
  //       204 => right(ApiResponseImpl(
  //           myData: {},
  //           isList: null,
  //           fromJson: (e) {
  //             return "";
  //           })),
  //       _ => left(ValidationFailure(
  //           errorMessageHandler(jsonDecode(response.data['data']))))
  //     };
  //   } on DioException catch (e) {
  //     return left(_handleDioError(e));
  //   }
  // }

  // Future<Either<Failure, ApiResponseImpl<List<SkillData>>>> getServiceList(
  //     String query) async {
  //   try {
  //     final response = await dioClient.request(
  //       type: MethodType.get,
  //       url: ApiEndpoints.serviceList,
  //       queryParams: {"search": query},
  //     );
  //     return switch (response.statusCode) {
  //       201 || 200 => right(
  //   ApiResponseImpl(
  //       myData: jsonDecode(response.data),
  //       isList: true,
  //       fromJsonList: (e) {
  //         return e.map((item) => SkillData.fromJson(item)).toList();
  //       }),
  // ),
  //       _ => left(
  //           ValidationFailure(errorMessageHandler(jsonDecode(response.data))))
  //     };
  //   } on DioException catch (e) {
  //     return left(_handleDioError(e));
  //   }
  // }

  // FromJson<MyServiceDataType?> fromJson = (json) {
  //   return switch (json) {
  //     {
  //       "service_name": String? serviceName,
  //       "skills_service_name": String? skillsServiceName,
  //       "cover_photo": String? coverPhoto,
  //       "average_rating": int? averageRating,
  //       "is_verified": bool? isVerified,
  //     } =>
  //       (
  //         serviceName: serviceName,
  //         skillsServiceName: skillsServiceName,
  //         coverPhoto: coverPhoto,
  //         averageRating: averageRating,
  //         isVerified: isVerified
  //       ),
  //     _ => (null)
  //   };
  // };

  Failure _handleDioError(DioException error) {
    Failure failureType = switch (error.type) {
      DioExceptionType.cancel => CancelFailure(),
      DioExceptionType.connectionTimeout => ConnectionTimeOutFailure(),
      DioExceptionType.connectionError => ConnectionFailure(),
      DioExceptionType.badCertificate => BadCertificateFailure(),
      DioExceptionType.badResponse => BadResponseFailure(
          message: errorMessageHandler(error.response?.data['data'])),
      DioExceptionType.receiveTimeout => ReceivedTimeOutFailure(),
      DioExceptionType.sendTimeout => SendTimeOutFailure(),
      DioExceptionType.unknown => ServerFailure(),
    };

    return failureType;
  }

  String errorMessageHandler(dynamic error) {
    // log("error :$")
    dynamic newMap = {};
    if (error.runtimeType != String) {
      newMap = Map<String, dynamic>.from(error);
    } else {
      newMap = error;
    }
    return switch (newMap) {
      String error => error,
      {"detail": String error} => error,
      _ => newMap.values.first.first,
    };
  }
}
