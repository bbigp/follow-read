import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:follow_read/utils/logger.dart';
import 'package:http/http.dart' as http;

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;
  HttpUtil._internal();

  static const String _baseUrl = 'https://mflux.coolbet.cn/v1/';
  static const int _timeoutSeconds = 15;
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // 添加全局Header（如认证token）
  void setAuthorization(String token) {
    _headers['X-Auth-Token'] = token;
  }

  Future<T?> safeRequest<T>({
    required String path,
    required HttpMethod method,
    required T Function(Map<String, dynamic>) fromJson,
    void Function(ApiException)? onError,
  }) async {
    final startTime = DateTime.now(); // 记录请求开始时间
    final requestId = '${startTime.millisecondsSinceEpoch}_${path.replaceAll('/', '_')}'; // 生成唯一请求ID

    // 打印请求开始日志
    _logRequestStart(
      requestId: requestId,
      path: path,
      method: method,
      // parameters: parameters,
    );
    try {
      final response = await request<T>(
        path: path,
        method: method,
        fromJson: fromJson,
      );
      // 打印成功日志
      _logRequestSuccess(
        requestId: requestId,
        path: path,
        duration: DateTime.now().difference(startTime),
        data: response, // 假设返回数据可被转换为Map
      );

      return response;
    } on ApiException catch (e, stackTrace) {
      _logRequestError(
        requestId: requestId,
        path: path,
        error: e,
        stackTrace: stackTrace,
      );

      onError?.call(e);
      if (onError == null) {
        handleGlobalError(e);
      }
      return null;
    }
  }

  static void Function(ApiException) handleGlobalError = (e) {
    print('全局错误: ${e.message}');
  };

  // 通用请求方法
  Future<T> request<T>({
    required String path,
    required HttpMethod method,
    required T Function(Map<String, dynamic>) fromJson,
    dynamic body,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + path).replace(
        queryParameters: queryParams,
      );

      final response = await _sendRequest(
        uri: uri,
        method: method,
        body: body,
      ).timeout(const Duration(seconds: _timeoutSeconds));
      if (response.statusCode == 200) {
        return fromJson(json.decode(response.body));
      } else {
        throw ApiException(1003, "Service Error", '请求失败: ${response.statusCode}',);
      }
    } on SocketException {
      throw ApiException(1001, 'Network Error', '请检查网络连接');
    } on TimeoutException {
      throw ApiException(1002, 'Timeout', '请求超时，请重试');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(9999, 'Unknown Error', '未知错误: ${e.toString()}');
    }
  }

  // 处理文件上传
  Future<T> uploadFile<T>({
    required String path,
    required File file,
    String fieldName = 'file',
    Map<String, String>? formData,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final uri = Uri.parse(_baseUrl + path);
      final request = http.MultipartRequest('POST', uri)
        ..headers.addAll(_headers)
        ..files.add(await http.MultipartFile.fromPath(fieldName, file.path));

      if (formData != null) {
        request.fields.addAll(formData);
      }

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      return _handleResponse<T>(responseBody, fromJson);
    } catch (e) {
      throw ApiException(3001, 'Upload Failed', '文件上传失败: ${e.toString()}');
    }
  }

  Future<http.Response> _sendRequest({
    required Uri uri,
    required HttpMethod method,
    dynamic body,
  }) async {
    switch (method) {
      case HttpMethod.get:
        return await http.get(uri, headers: _headers);
      case HttpMethod.post:
        return await http.post(uri, headers: _headers, body: _encodeBody(body));
      case HttpMethod.put:
        return await http.put(uri, headers: _headers, body: _encodeBody(body));
      case HttpMethod.delete:
        return await http.delete(uri, headers: _headers);
    }
  }

  String? _encodeBody(dynamic body) {
    if (body == null) return null;
    if (body is String) return body;
    return jsonEncode(body);
  }

  T _handleResponse<T>(http.Response response, T Function(dynamic)? fromJson) {
    final statusCode = response.statusCode;
    final responseBody = jsonDecode(utf8.decode(response.bodyBytes));

    if (statusCode >= 200 && statusCode < 300) {
      if (fromJson != null) {
        return fromJson(responseBody);
      } else if (T == dynamic) {
        return responseBody as T;
      } else {
        throw ApiException(
          1003,
          'Parser Error',
          '需要提供fromJson方法或使用dynamic类型',
        );
      }
    } else {
      throw ApiException(
        statusCode,
        responseBody['error'] ?? 'Server Error',
        responseBody['message'] ?? '未知服务器错误',
      );
    }
  }
}

enum HttpMethod { get, post, put, delete }

class ApiException implements Exception {
  final int code;
  final String error;
  final String message;

  ApiException(this.code, this.error, this.message);

  @override
  String toString() => '[Code:$code] $error: $message';
}


void _logRequestStart({
  required String requestId,
  required String path,
  required HttpMethod method,
  Map<String, dynamic>? parameters,
}) {
  logger.i(
    '''
=== 请求开始 ===
ID: $requestId
路径: $path
方法: ${method.name.toUpperCase()}
参数: ${parameters?.toString() ?? '无'}
    ''',
  );
}

void _logRequestSuccess<T>({
  required String requestId,
  required String path,
  required Duration duration,
  required T data,
}) {
  logger.i(
    '''
=== 请求成功 ===
ID: $requestId
路径: $path
耗时: ${duration.inMilliseconds}ms
响应数据: ${_tryConvertToLoggable(data)}
    ''',
  );
}

void _logRequestError({
  required String requestId,
  required String path,
  required ApiException error,
  required StackTrace stackTrace,
}) {
  logger.e(
    '''
=== 请求失败 ===
ID: $requestId
路径: $path
错误码: ${error.code}
错误信息: ${error.message}
堆栈追踪: ${stackTrace.toString()}
    ''',
  );
}

// 尝试将数据转换为可日志化的格式
dynamic _tryConvertToLoggable<T>(T data) {
  if (data is Map) {
    return data;
  } else if (data is List) {
    return {'count': data.length};
  } else if (data != null && data is! String) {
    try {
      return (data as dynamic).toJson(); // 尝试调用toJson方法
    } catch (_) {}
  }
  return data.toString();
}