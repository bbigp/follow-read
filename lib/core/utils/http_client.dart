

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:follow_read/core/prefs_keys.dart';
import 'package:get_storage/get_storage.dart';

import 'api_result.dart';
import 'logger.dart';

class HttpClient {
  static final Dio _dio = Dio()
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final box = GetStorage();
        final baseURL = box.read(PrefsKeys.baseUrl) ?? "";
        final token = box.read(PrefsKeys.token) ?? "";
        options.baseUrl = baseURL;
        options.headers["X-Auth-Token"] = token;
        options.headers["Content-Type"] = "application/json";

        logger.i('''
            === ➡️ [REQUEST] ===
            ${options.method} ${options.baseUrl}${options.path}
            Headers: ${options.headers}
            Query Parameters: ${options.queryParameters}
            Body: ${options.data}
        ''',
        );
        return handler.next(options);
      },
      onResponse: (response, handler) {
        logger.i('''
            === ✅ [RESPONSE] ===
            ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}
            Response data: ${response.data}
        ''',
        );
        return handler.next(response); //继续返回响应
      },
      onError: (DioException err, handler) {
        logger.i('''
            === ❌ [ERROR] ===
            ${err.response?.statusCode} ${err.requestOptions.method} ${err.requestOptions.path}
            Error message: ${err.message}
            Error data: ${err.response != null ? err.response!.data : ""}
        ''',
        );
        if (err.response != null) {
          handler.resolve(err.response!);
        } else {
          final fakeResponse = Response(
              requestOptions: err.requestOptions,
              statusCode: 500,
              data: err.message ?? "网络异常"
          );
          return handler.resolve(fakeResponse);
        }
      },
    ));

  static Dio _createDio(String baseUrl, String token) {
    return Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "X-Auth-Token": token,
        "Content-Type": "application/json",
      },
    ))..interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        debugPrint("✅ [RESPONSE] ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
        debugPrint("Response data: ${response.data}");
        return handler.next(response); //继续返回响应
      },
      onError: (DioException err, handler) {
        debugPrint("❌ [ERROR] ${err.response?.statusCode} ${err.requestOptions.method} ${err.requestOptions.path}");
        debugPrint("Error message: ${err.message}");
        final response = err.response;
        if (err.response != null) {
          debugPrint("Error data: ${response!.data}");
          handler.resolve(response);
        } else {
          final fakeResponse = Response(
              requestOptions: err.requestOptions,
              statusCode: 500,
              data: err.message ?? "网络异常"
          );
          return handler.resolve(fakeResponse);
        }
      },
    ));
  }

  static Dio _configureDio(String? baseUrl, String? token) {
    if (baseUrl == null && token == null) {
      return _dio;
    }
    return _createDio(baseUrl!, token!); // 安全创建一个独立实例
  }

  static Future<ApiResult<T>> get<T>(String path, T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? query,
    String? baseUrl, String? token,
  }) async {
    final response = await _configureDio(baseUrl, token).get(path, queryParameters: query);
    final json = response.data;
    if (response.isSuccess) {
      return ApiResult.success(fromJson(json));
    }
    String message = "未知错误";
    if (json is Map<String, dynamic> && json.containsKey('error_message')) {
      message = json['error_message'];
    } else if (json is String) {
      message = json;
    }
    return ApiResult.failure(message);
  }



  static Future<ApiResult<T>> post<T>(String path, T Function(Map<String, dynamic>) fromJson, {
    dynamic data,
    Map<String, dynamic>? query,
    String? baseUrl, String? token,
  }) async {
    final response = await _configureDio(baseUrl, token).post(path, queryParameters: query, data: data);
    final json = response.data;
    if (response.isSuccess) {
      return ApiResult.success(fromJson(json));
    }
    String message = "未知错误";
    if (json is Map<String, dynamic> && json.containsKey('error_message')) {
      message = json['error_message'];
    } else if (json is String) {
      message = json;
    }
    return ApiResult.failure(message);
  }

}

extension ResponseExtension on Response {
  bool get isSuccess {
    return statusCode != null && statusCode! >= 200 && statusCode! < 300;
  }
}
