import 'package:dio/dio.dart';

class MockInterceptor implements Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(err);
    handler.next(err);
    // TODO: implement onError
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(options);
    handler.next(options);
    // TODO: implement onRequest
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response);
    handler.next(response);
    // TODO: implement onResponse
  }
}
