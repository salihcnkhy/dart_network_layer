class BaseServerModel {
  BaseServerModel({required this.isSuccess});
  bool isSuccess;

  factory BaseServerModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return BaseServerModel(isSuccess: map["isSuccess"]);
  }
}
