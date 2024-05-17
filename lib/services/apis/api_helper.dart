import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:home_brigadier/consts/static_data.dart';
import 'package:http/http.dart' as http;

import 'api_endpoints.dart';
import 'error_handler.dart';
import 'toast.dart';

class ApiHelper {
  final Dio _dio;

  ApiHelper() : _dio = Dio() {
    // You can add any global configurations for Dio here
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer ${StaticData.accessToken}';
  }

  Future<Response> get(String endpoint, {bool includeToken = false}) async {
    try {
      // Adjust headers based on the includeToken parameter
      if (includeToken) {
        _dio.options.headers['Authorization'] =
            'Bearer ${StaticData.accessToken}';
      } else {
        _dio.options.headers.remove('Authorization');
      }

      Response response = await _dio.get("${ApiEndpoints.BASEURL}$endpoint");
      if (response.statusCode == 200) {
        return response;
      } else {
        // handleError(response);
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      // handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      Response response =
          await _dio.post('${ApiEndpoints.BASEURL}$endpoint', data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response;
      } else {
        // handleError(response);
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  //========
  Future<Map<String, dynamic>> httppost(
    String endpoint,
    dynamic data,
  ) async {
    try {
      final String url = '${ApiEndpoints.BASEURL}$endpoint';
      final String jsonData = jsonEncode(data);
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${StaticData.accessToken}',
      };
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonData,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        return responseBody;
      } else {
        throw Exception(
            'Request failed with statussss: ${response.statusCode}');
      }
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      Response response = await _dio.delete('${ApiEndpoints.BASEURL}$endpoint');
      if (response.statusCode == 200) {
        return response;
      } else {
        // handleError(response);
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> update(String endpoint, dynamic data) async {
    try {
      Response response =
          await _dio.put('${ApiEndpoints.BASEURL}$endpoint', data: data);
      if (response.statusCode == 200) {
        return response;
      } else {
        // handleError(response);
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }
}

class ApiHelper2 {
  final Dio dio;
  final List<CancelToken> _cancelTokens = [];

  ApiHelper2() : dio = Dio() {
    dio.options
      ..baseUrl = ApiEndpoints.BASEURL
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10)
      ..headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
  }

  Future<Response> request({
    required String endpoint,
    String method = 'GET',
    Map<String, dynamic>? data,
  }) async {
    final CancelToken cancelToken = CancelToken();
    _cancelTokens.add(cancelToken);

    try {
      final token = await _getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      switch (method.toUpperCase()) {
        case 'POST':
          return await dio.post(endpoint, data: data, cancelToken: cancelToken);
        case 'PUT':
          return await dio.put(endpoint, data: data, cancelToken: cancelToken);
        case 'DELETE':
          return await dio.delete(endpoint, cancelToken: cancelToken);
        case 'PATCH':
          return await dio.delete(endpoint, cancelToken: cancelToken);
        default:
          return await dio.get(endpoint, cancelToken: cancelToken);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        showSnackBar("Request timeout. Unstable internet connection", true);
      } else if (e.error is SocketException) {
        showSnackBar("No Internet connection", true);
      }
      // Cancel all ongoing requests
      for (var token in _cancelTokens) {
        token.cancel('Request aborted due to error');
      }
      return Response(
          requestOptions: RequestOptions(path: ''), statusCode: 500);
    }
  }

  Future<String> _getToken() async {
    return StaticData.accessToken;
  }
}
