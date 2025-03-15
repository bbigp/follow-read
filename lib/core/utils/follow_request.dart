

import 'dart:convert';

import 'package:http/http.dart' as http;

class FollowRequest {

  static Future<http.Response> sendRequest({
    required Uri uri,
    required HttpMethod method,
    required Map<String, String> headers,
    dynamic body,
  }) async {
    switch (method) {
      case HttpMethod.get:
        return await http.get(uri, headers: headers);
      case HttpMethod.post:
        return await http.post(uri, headers: headers, body: _encodeBody(body));
      case HttpMethod.put:
        return await http.put(uri, headers: headers, body: _encodeBody(body));
      case HttpMethod.delete:
        return await http.delete(uri, headers: headers);
    }
  }

  static String? _encodeBody(dynamic body) {
    if (body == null) return null;
    if (body is String) return body;
    return jsonEncode(body);
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






// // 处理文件上传
// Future<T> uploadFile<T>({
//   required String path,
//   required File file,
//   String fieldName = 'file',
//   Map<String, String>? formData,
//   T Function(dynamic)? fromJson,
// }) async {
//   try {
//     final uri = Uri.parse(_baseUrl + path);
//     final request = http.MultipartRequest('POST', uri)
//       ..headers.addAll(_headers)
//       ..files.add(await http.MultipartFile.fromPath(fieldName, file.path));
//
//     if (formData != null) {
//       request.fields.addAll(formData);
//     }
//
//     final response = await request.send();
//     final responseBody = await http.Response.fromStream(response);
//
//     return _handleResponse<T>(responseBody, fromJson);
//   } catch (e) {
//     throw ApiException(3001, 'Upload Failed', '文件上传失败: ${e.toString()}');
//   }
// }