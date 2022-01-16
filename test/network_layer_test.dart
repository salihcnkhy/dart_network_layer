import 'package:flutter_test/flutter_test.dart';
import 'package:network_layer/mock/mock_options_provider.dart';
import 'package:network_layer/mock/server_request.dart';
import 'package:network_layer/mock/server_response.dart';
import 'package:network_layer/network_manager.dart';
import 'package:network_layer/providers/request_provider.dart';

void main() {
  test('network request test', () async {
    final optionProvider = MockOptionsProvider();
    final networkManager = NetworkManager(optionProvider);
    for (var i = 1; i <= 3; i++) {
      print(
          "***************************\n**** $i. Request ****\n***************************");
      final requestModel =
          SignInRequest(email: "test@test.com", password: "123456").toJson();
      final requestProvider = RequestProvider<BaseServerModel>(
          baseUrl: "https://hesabinibil.azurewebsites.net/api",
          path: "/Auth/SignIn",
          method: HttpMethod.post,
          mapper: (map) => BaseServerModel.fromMap(map),
          requestData: requestModel);
      final data = await networkManager.execute(requestProvider);
      final s = await data.asFuture;
      expect(true, s.isSuccess);
    }
  });
}
