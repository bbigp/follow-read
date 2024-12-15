import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_response.dart';
import 'logger.dart';

class HttpService {
  // static const String baseUrl = 'http://192.168.1.6:1400/v1/'; // 替换为你的基础URL
  static const String baseUrl = 'https://mflux.coolbet.cn/v1/';

  // 单例模式
  static final HttpService _instance = HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal();

  static Future<ApiResponse> get(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _createHeader(headers),
      );
      logger.d("url: ${Uri.parse('$baseUrl$endpoint')}, data:${response.body}");
      return _handleResponse(response);
    } catch (e) {
      return ApiResponse.error('网络请求失败: $e');
    }
  }

  static Map<String, String> _createHeader(Map<String, String>? headers){
    if (headers != null) {
      headers['Content-Type'] = 'application/json';
    } else {
      headers = {'Content-Type': 'application/json'};
    }
    headers['X-Auth-Token'] = 'lOEQiLk-6QtDmiIz9_AsoBmZrdeKBarjZyjTLyo4600=';
    return headers;
  }

  static ApiResponse _handleResponse(http.Response response) {
    try {
      final data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.success(data);
      } else {
        return ApiResponse.error(
          data['message'] ?? '请求失败',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('数据解析失败: $e');
    }
  }
}
