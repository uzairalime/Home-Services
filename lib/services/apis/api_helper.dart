import 'package:dio/dio.dart';
import 'package:home_brigadier/consts/static_data.dart';

import 'api_endpoints.dart';
import 'error_handler.dart';

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

      Response response = await _dio.get("$BASEURL$endpoint");
      if (response.statusCode == 200) {
        return response;
      } else {
        handleError(response);
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      Response response = await _dio.post('$BASEURL$endpoint', data: data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response;
      } else {
        handleError(response);
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      Response response = await _dio.delete('$BASEURL$endpoint');
      if (response.statusCode == 200) {
        return response;
      } else {
        handleError(response);
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }

  Future<Response> update(String endpoint, dynamic data) async {
    try {
      Response response = await _dio.put('$BASEURL$endpoint', data: data);
      if (response.statusCode == 200) {
        return response;
      } else {
        handleError(response);
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      handleError(e);
      rethrow;
    }
  }
}
