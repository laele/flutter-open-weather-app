import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
}

// Location Failure
class LocationServiceDisabledFailure extends Failure {
  const LocationServiceDisabledFailure() : super(message: 'Location services are disabled.');

  @override
  List<Object?> get props => [super.message];
}

class LocationPermissionDeniedFailure extends Failure {
  const LocationPermissionDeniedFailure() : super(message: 'Location permission denied.');

  @override
  List<Object?> get props => [super.message];
}

class LocationPermissionDeniedForeverFailure extends Failure {
  const LocationPermissionDeniedForeverFailure() : super(message: 'Location permission denied forever.');

  @override
  List<Object?> get props => [super.message];
}

/////////
///
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No Internet connection.'});

  @override
  List<Object?> get props => [super.message];
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({super.message = "There was a problem with the server. Please try again later.", this.statusCode});

  @override
  List<Object?> get props => [super.message, statusCode];
}

class ParssingFailure extends Failure {
  const ParssingFailure({required super.message});

  @override
  List<Object?> get props => [super.message];
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache data error.'});

  @override
  List<Object?> get props => [super.message];
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'Unknown error.'});

  @override
  List<Object?> get props => [super.message];
}
