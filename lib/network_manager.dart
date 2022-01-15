import 'package:async/async.dart';
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
  Future<Result<R>> execute<R>(RequestProvider<R> requestProvider) async {
    final request = requestProvider.getRequestOption();
    print(request.uri);
    final response = await _dio.fetch(request);
    return _getResultFromResponse(response, requestProvider.mapper);
  }

  Result<R> _getResultFromResponse<R>(
      Response<dynamic> response, Mapper<R> mapper) {
    final data = response.data;
    if (data == null) {
      return Result.error(NetworkLayerError(message: "Data is null"));
    }
    try {
      final map = data as Map<String, dynamic>;
      final serialized = mapper(map);
      return Result.value(serialized);
    } catch (e) {
      return Result.error(
          NetworkLayerError(message: "Couldn't Convert Data To Map"));
    }
  }
}
