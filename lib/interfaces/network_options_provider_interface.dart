import 'package:dio/dio.dart';

abstract class NetworkOptionsProviderInterface {
  List<Interceptor> getInterceptors();
  Transformer? getTransformer();
}
