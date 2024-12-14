import 'package:http/http.dart' as http;
import 'dart:convert';

import 'api_response.dart';
import 'logger.dart';

class HttpService {
  static const String baseUrl = 'https://mflux.coolbet.cn/v1/'; // 替换为你的基础URL

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
        headers: headers ?? {'Content-Type': 'application/json'},
      );
      return _handleResponse(response);
    } catch (e) {
      return ApiResponse.error('网络请求失败: $e');
    }
  }

  static ApiResponse _handleResponse(http.Response response) {
    try {
      logger.i(response.body);
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
