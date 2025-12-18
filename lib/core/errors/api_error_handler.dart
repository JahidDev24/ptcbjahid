import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String parseError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return "Connection timed out. Please check your internet.";

        case DioExceptionType.badResponse:
          return _handleStatusCode(error.response?.statusCode);

        case DioExceptionType.connectionError:
          return "No internet connection available.";

        case DioExceptionType.cancel:
          return "Request to server was cancelled.";

        case DioExceptionType.unknown:
        default:
          return "Unexpected error occurred. Please try again.";
      }
    } else {
      return "Something went wrong. Please try again.";
    }
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad Request.";
      case 401:
        return "Unauthorized. Please login again.";
      case 403:
        return "Access forbidden.";
      case 404:
        return "Resource not found.";
      case 500:
        return "Internal server error.";
      case 502:
        return "Bad gateway.";
      default:
        return "Oops! Something went wrong.";
    }
  }
}
