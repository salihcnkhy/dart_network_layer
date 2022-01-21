class MockBaseResponse {
  MockBaseResponse({required this.isSuccess});
  bool isSuccess;

  factory MockBaseResponse.fromMap(Map<String, dynamic> map) {
    return MockBaseResponse(isSuccess: map["isSuccess"]);
  }
}
