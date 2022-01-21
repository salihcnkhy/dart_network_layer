import 'package:network_layer/providers/request_provider.dart';

abstract class NetworkManagerInterface {
  Future<R> execute<R>(RequestProvider<R> requestProvider);
}
