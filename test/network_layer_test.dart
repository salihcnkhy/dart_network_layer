import 'dart:convert';
import 'dart:io';

import 'package:dio/src/adapter.dart';
import 'package:dio/src/dio_error.dart';
import 'package:dio/src/dio_mixin.dart';
import 'package:dio/src/options.dart';
import 'package:dio/src/response.dart';
import 'package:dio/src/transformer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_layer/interfaces/network_options_provider_interface.dart';
import 'package:network_layer/network_manager.dart';
import 'package:network_layer/providers/request_provider.dart';

void main() {
  test('network request test', () async {
    final optionProvider = MockOptionsProvider();
    final networkManager = NetworkManager(optionProvider);
    for (var i = 0; i < 10; i++) {
      final requestModel =
          BaseServerRequest(userID: "dfs", userToken: "sdf").toJson();
      final requestProvider = RequestProvider<BaseServerModel>(
          path: "/Auth/SignIn",
          method: HttpMethod.post,
          mapper: (map) => BaseServerModel.fromMap(map),
          requestData: requestModel);
      final data = await networkManager.execute(requestProvider);
      final s = await data.asFuture;
      expect(false, s.isSuccess);
    }
  });
}

class MockOptionsProvider implements NetworkOptionsProviderInterface {

  @override
  List<Interceptor> getInterceptors() {
    return [MockInterceptor()];
  }

  @override
  Transformer? getTransformer() {}
}

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

class BaseServerModel {
  BaseServerModel({required this.isSuccess});
  bool isSuccess;

  factory BaseServerModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return BaseServerModel(isSuccess: map["isSuccess"]);
  }
}

class BaseServerRequest {
  String userToken;
  String userID;
  BaseServerRequest({required this.userID, required this.userToken});

  Map<String, dynamic> toJson() {
    return {
      "userToken": userToken,
      "userID": userID,
    };
  }
}
