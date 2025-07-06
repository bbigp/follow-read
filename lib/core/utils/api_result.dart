

class ApiResult<T> {
  final bool success;
  final T? data;
  final String message;

  ApiResult.success(this.data)
      : success = true,
        message = "";

  ApiResult.failure(this.message)
      : success = false,
        data = null;
}

extension ApiResultX<S> on ApiResult<S> {
  ApiResult<T> map<T>(T Function(S) mapper) {
    if (success && data != null) {
      return ApiResult.success(mapper(data!));
    } else {
      return ApiResult.failure(message);
    }
  }
}