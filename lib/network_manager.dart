import 'package:dio/dio.dart';
import 'package:network_layer/interfaces/network_options_provider_interface.dart';
import 'package:network_layer/providers/request_provider.dart';
import 'interfaces/network_manager_interface.dart';
import 'model/layer_error.dart';

class NetworkManager implements NetworkManagerInterface {
  late Dio _dio;

  NetworkManager(NetworkOptionsProviderInterface optionsProvider) {
    _dio = Dio();
    _dio.interceptors.addAll(optionsProvider.getInterceptors());

    final transformer = optionsProvider.getTransformer();
    if (transformer != null) _dio.transformer = transformer;
  }

  @override
  Future<R> execute<R>(RequestProvider<R> requestProvider) async {
    final request = requestProvider.getRequestOption();
    print(request.uri);

    try {
      final response = await _dio.fetch(request);
      return _createGenericFuture(response, requestProvider.mapper);
    } on DioError catch (e) {
      return Future.error(NetworkLayerError(message: e.message));
    }
  }

  Future<R> _createGenericFuture<R>(
      Response<dynamic> response, Mapper<R> mapper) {
    try {
      final data = response.data;
      if (data == null) {
        return Future.error(NetworkLayerError(message: "Data is null"));
      }
      final map = data as Map<String, dynamic>;
      final serialized = mapper(map);
      return Future.value(serialized);
    } catch (e) {
      return Future.error(e);
    }
  }
}
