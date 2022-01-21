import 'package:dio/dio.dart';

class MockInterceptor implements Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("interceptor onError: $err");
    handler.next(err);
    // TODO: implement onError
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("interceptor onRequest: ${options.data}");
    handler.next(options);
    // TODO: implement onRequest
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("interceptor onRepose: $response");
    handler.next(response);
    // TODO: implement onResponse
  }
}
