import 'package:dio/dio.dart';
import 'package:flutter_weather_app/core/error/exceptions.dart';

Exception mapDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return const NetworkException(message: 'No internet connection.');

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      if (statusCode == 404) {
        return NotFoundException();
      }
      return ServerException(statusCode: statusCode, message: 'Server error ${statusCode}');

    case DioExceptionType.cancel:
      return UnknownException(message: 'Request cancelled');

    case DioExceptionType.badCertificate:
      return NetworkException(message: 'Invalid security certificate');

    case DioExceptionType.unknown:
      return UnknownException(message: e.message ?? 'Unknown error');
  }
}
