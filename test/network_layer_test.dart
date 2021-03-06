import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_layer/mock/mock_options_provider.dart';
import 'package:network_layer/mock/server_request.dart';
import 'package:network_layer/mock/server_response.dart';
import 'package:network_layer/network_manager.dart';
import 'package:network_layer/providers/request_provider.dart';

void main() {
  final optionProvider = MockOptionsProvider();
  final networkManager = NetworkManager(optionProvider);

  test('network request test', () async {
    final requestModel =
        SignInRequest(email: "test@test.com", password: "123456").toJson();
    final requestProvider = RequestProvider<MockBaseResponse>(
        baseUrl: "https://hesabinibil.azurewebsites.net/api",
        path: "/Auth/SignIn",
        method: HttpMethod.post,
        mapper: (map) => MockBaseResponse.fromMap(map),
        requestData: requestModel);
    final data = await networkManager.execute(requestProvider);
    final s = data;
    expect(true, s.isSuccess);
  });

  test('future error', () async {
    final requestModel =
        SignInRequest(email: "test@test.com", password: "123456").toJson();
    final requestProvider = RequestProvider<MockBaseResponse>(
        baseUrl: "",
        path: "/Auth/SignIn",
        method: HttpMethod.post,
        mapper: (map) => MockBaseResponse.fromMap(map),
        requestData: requestModel);

    final data =
        await networkManager.execute(requestProvider).catchError((error) {
      print(error);
      return MockBaseResponse(isSuccess: false);
    });

    expect(false, data.isSuccess);
  });
}
