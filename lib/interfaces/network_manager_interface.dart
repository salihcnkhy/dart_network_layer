import 'package:async/async.dart';
import 'package:network_layer/providers/request_provider.dart';

abstract class NetworkManagerInterface {
  Future<Result<R>> execute<R>(RequestProvider<R> requestProvider);
}
