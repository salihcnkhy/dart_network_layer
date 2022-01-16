import 'package:dio/dio.dart';
import 'package:network_layer/interfaces/network_options_provider_interface.dart';

import 'mock_interceptor.dart';

class MockOptionsProvider implements NetworkOptionsProviderInterface {
  @override
  List<Interceptor> getInterceptors() {
    return [MockInterceptor()];
  }

  @override
  Transformer? getTransformer() {}
}
