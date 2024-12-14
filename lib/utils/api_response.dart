class ApiResponse<T> {
  final T? data;
  final String? error;
  final bool success;
  final int? statusCode;

  ApiResponse({
    this.data,
    this.error,
    this.statusCode,
    this.success = false,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse(
      data: data,
      success: true,
      statusCode: 200,
    );
  }

  factory ApiResponse.error(String error, {int? statusCode}) {
    return ApiResponse(
      error: error,
      success: false,
      statusCode: statusCode,
    );
  }
}
