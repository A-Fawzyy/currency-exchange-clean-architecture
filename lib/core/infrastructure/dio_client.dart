import 'package:currency_exchange/core/infrastructure/base_network_client.dart';
import 'package:currency_exchange/util/api_constants.dart';
import 'package:dio/dio.dart';

class DioClient extends BaseNetworkClient {
  final Dio _dio;
  final String _baseUrl;
  final String _apiKey;

  DioClient(this._dio, this._baseUrl, this._apiKey);

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        _baseUrl + path,
        queryParameters: _getQueryParams(queryParameters),
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  Map<String, dynamic> _getQueryParams(Map<String, dynamic>? queryParameters) {
    final result = <String, dynamic>{};
    queryParameters?.forEach((key, value) => result[key] = value);
    result[ApiQueryParamsKeys.apiKey] = _apiKey;
    return result;
  }
}
