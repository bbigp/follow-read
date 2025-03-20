import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:follow_read/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/domain/models/user.dart';
import 'failure.dart';
import 'follow_request.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  HttpUtil._internal();

  static const int _timeoutSeconds = 15;
  final Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  String buildPath(String baseUrl, String path) {
    if (baseUrl.endsWith("/")) {
      return baseUrl + path;
    }
    return "$baseUrl/$path";
  }


  Map<String, String> buildHeaders(Map<String, String> headers, String token) {
    headers['X-Auth-Token'] = token;
    return headers;
  }


  Future<(String, String)> _getAuthInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('cachedUser');
    if (json == null) {
      return ("", "");
    }
    final user = UserMapper.fromJson(jsonDecode(json));
    return (user.baseUrl, user.token);
  }

  Future<Either<Failure, T>> safeRequest<T>({
    required String path,
    required HttpMethod method,
    required T Function(String) fromJson,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    final startTime = DateTime.now(); // 记录请求开始时间
    final requestId =
        '${startTime.millisecondsSinceEpoch}_${path.replaceAll('/', '_')}'; // 生成唯一请求ID

    // 打印请求开始日志
    _logRequestStart(
      requestId: requestId,
      path: path,
      method: method,
      parameters: queryParams,
    );
    try {
      final (baseUrl, token) = await _getAuthInfo();
      final isAbsolutePath = path.startsWith("http");
      var uri = isAbsolutePath ? Uri.parse(path) : Uri.parse(buildPath(baseUrl, path));
      final encodedParams = _encodeQueryParams(queryParams);
      uri = uri.replace(queryParameters: {
        ...uri.queryParameters, // 保留路径中已有的参数
        ...encodedParams,       // 添加新参数
      });

      var h = defaultHeaders;
      if (headers != null) {
        h = headers;
      }
      if (token != "") {
        h = buildHeaders(h, token);
      }

      final response = await FollowRequest.sendRequest(
        uri: uri,
        method: method,
        headers: h,
      ).timeout(const Duration(seconds: _timeoutSeconds));

      if (response.statusCode == 200) {
        final result = fromJson(utf8.decode(response.bodyBytes));
        _logRequestSuccess(
          requestId: requestId,
          path: path,
          duration: DateTime.now().difference(startTime),
          data: result, // 假设返回数据可被转换为Map
        );
        return Right(result);
      } else {
        throw ApiException(
          1003,
          "Service Error",
          '请求失败: ${response.statusCode}',
        );
      }
    } on ApiException catch (e, stackTrace) {
      _logRequestError(
        requestId: requestId,
        path: path,
        error: e,
        stackTrace: stackTrace,
      );
      return Left(Failure(e.code, e.error));
    } on SocketException catch (e, stackTrace) {
      final error = ApiException(1001, 'Network Error', '请检查网络连接');
      _logRequestError(
        requestId: requestId,
        path: path,
        error: error,
        stackTrace: stackTrace,
      );
      return Left(Failure(error.code, error.error));
    } on TimeoutException catch (e, stackTrace) {
      final error = ApiException(1002, 'Timeout', '请求超时，请重试');
      _logRequestError(
        requestId: requestId,
        path: path,
        error: error,
        stackTrace: stackTrace,
      );
      return Left(Failure(error.code, error.error));
    } catch (e, stackTrace) {
      final error =
          ApiException(9999, 'Unknown Error', '未知错误: ${e.toString()}');
      _logRequestError(
        requestId: requestId,
        path: path,
        error: error,
        stackTrace: stackTrace,
      );
      return Left(Failure(error.code, error.error));
    }
  }

  Map<String, String> _encodeQueryParams(Map<String, dynamic>? params) {
    return params?.map((key, value) {
      if (value == null) return MapEntry(key, '');

      // 处理列表类型参数 (根据API需求选择逗号分隔或多参数)
      if (value is Iterable) {
        return MapEntry(key, value.map((e) => _valueToString(e)).join(','));
      }

      return MapEntry(key, _valueToString(value));
    }) ?? {};
  }

  String _valueToString(dynamic value) {
    if (value is String) return value;
    if (value is bool) return value.toString();
    if (value is num) return value.toString();
    if (value is DateTime) return value.toIso8601String();
    throw ArgumentError('Unsupported query parameter type: ${value.runtimeType}');
  }

  static void Function(ApiException) handleGlobalError = (e) {
    // print('全局错误: ${e.message}');
  };

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
}
