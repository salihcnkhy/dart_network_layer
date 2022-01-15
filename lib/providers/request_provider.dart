import 'package:dio/dio.dart';

typedef Mapper<R> = R Function(Map<String, dynamic>);

class RequestProvider<ResponseType> {
  String _path;
  HttpMethod _method;
  dynamic _requestData;
  Mapper<ResponseType> _mapper;
  ContentType _contentType;
  String baseUrl = "https://hesabinibil.azurewebsites.net/api";
  RequestProvider(
      {required String path,
      required HttpMethod method,
      required Mapper<ResponseType> mapper,
      dynamic requestData,
      ContentType contentType = ContentType.json})
      : _path = path,
        _method = method,
        _mapper = mapper,
        _requestData = requestData,
        _contentType = contentType;

  RequestOptions getRequestOption() {
    return RequestOptions(
        baseUrl: baseUrl,
        path: _path,
        method: _method.string,
        data: _requestData,
        contentType: _contentType.type);
  }

  Mapper<ResponseType> get mapper {
    return _mapper;
  }
}

enum HttpMethod { post, get, put }

extension HttpMethodExtension on HttpMethod {
  String get string {
    switch (this) {
      case HttpMethod.post:
        return "POST";
      case HttpMethod.get:
        return "GET";
      case HttpMethod.put:
        return "PUT";
    }
  }
}

enum ContentType { json }

extension ContentTypeExtension on ContentType {
  String get type {
    switch (this) {
      case ContentType.json:
        return "application/json";
    }
  }
}
