library network_layer;

import 'interfaces/network_manager_interface.dart';
import 'mock/mock_options_provider.dart';
import 'network_manager.dart';

class MockNetworkProperties {
  static NetworkManagerInterface networkManager =
      NetworkManager(MockOptionsProvider());

  static String baseUrl = "https://hesabinibil.azurewebsites.net/api";
}
