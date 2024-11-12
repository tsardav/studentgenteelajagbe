import '../utils/utils.dart';

class DioClient {
  final Dio _dio = Dio();
  DioClient() {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.contentType = Headers.jsonContentType
      ..options.responseType = ResponseType.plain
      ..options.validateStatus = (value) {
        return true;
      }
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (e, handler) async {
          // String? token = await CacheStorage().getAccessToken();
          // // log(AppRouter.router.location());
          // if (AppRouter.router.location() != "/sign_up" &&
          //     AppRouter.router.location() != "/sign_in" &&
          //     AppRouter.router.location() != "/forgot_password" &&
          //     AppRouter.router.location() != "/verify_email" &&
          //     AppRouter.router.location() != "/set_new_password") {
          //   e.headers['Authorization'] = 'Bearer $token';
          // }
          // log("headers: ${e.headers}");
          handler.next(e);
        },
        onResponse: (e, handler) {
          handler.next(e);
        },
        onError: (error, handler) => handler.next(error),
      ))
      ..interceptors.add(DioInterceptors())
      // ..interceptors.add(PrettyDioLogger(
      //   requestHeader: true,
      //   // requestBody: true,
      //   responseBody: true,
      //   // responseHeader: true,
      // ))
      ..interceptors.add(RetryOnConnectionChangeInterceptor(dio: _dio));
  }

  Future<Response> request({
    required MethodType type,
    required String url,
    dynamic body,
    Map<String, dynamic>? queryParams,
  }) {
    return switch (type) {
      MethodType.post =>
        _dio.post(url, data: body, queryParameters: queryParams),
      MethodType.get => _dio.get(url, queryParameters: queryParams),
      MethodType.put => _dio.put(url, data: body, queryParameters: queryParams),
      MethodType.patch =>
        _dio.patch(url, data: body, queryParameters: queryParams),
      MethodType.delete => _dio.delete(
          url,
          queryParameters: queryParams,
          options: Options(
            contentType: 'application/json',
            responseType: ResponseType.plain,
          ),
        ),
    };
  }

  Future<Response> formRequest({
    required MethodType type,
    required String url,
    required dynamic body,
    Map<String, dynamic>? queryParams,
  }) {
    return switch (type) {
      MethodType.post => _dio.post(
          url,
          data: body,
          queryParameters: queryParams,
          options: Options(
            contentType: "multipart/form-data",
            responseType: ResponseType.plain,
          ),
        ),
      MethodType.get => _dio.get(url, queryParameters: queryParams),
      MethodType.put => _dio.put(url, data: body, queryParameters: queryParams),
      MethodType.patch =>
        _dio.patch(url, data: body, queryParameters: queryParams),
      MethodType.delete => _dio.delete(url, queryParameters: queryParams),
    };
  }
}
