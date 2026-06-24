// Location Exceptions
class LocationServiceDisabledException implements Exception {}

class LocationPermissionDeniedException implements Exception {}

class LocationPermissionDeniedForeverException implements Exception {}

//

class NetworkException implements Exception {
  final String message;
  const NetworkException({this.message = 'Connection error'});
}

class NotFoundException implements Exception {}

class ServerException implements Exception {
  final int? statusCode;
  final String message;

  ServerException({this.statusCode, required this.message});
}

class ParsingException implements Exception {
  final String message;
  ParsingException({required this.message});
}

class UnknownException implements Exception {
  final String message;
  UnknownException({required this.message});
}

class CacheException implements Exception {}
