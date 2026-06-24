import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/features/location/domain/enums/location_permission_status.dart';
import 'package:flutter_weather_app/core/error/exceptions.dart';
import 'package:flutter_weather_app/features/location/data/data_source/location_data_source.dart';
import 'package:flutter_weather_app/features/location/domain/repositories/location_repository.dart';
import 'package:flutter_weather_app/core/error/failures.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource locationDataSource;
  LocationRepositoryImpl({required this.locationDataSource});

  @override
  Future<Either<Failure, CoordinatesEntity>> getCurrentLocation() async {
    try {
      final location = await locationDataSource.getCurrentLocation();
      return right(location);
    } on LocationServiceDisabledException {
      return left(LocationServiceDisabledFailure());
    } on LocationPermissionDeniedException {
      return left(LocationPermissionDeniedFailure());
    } on LocationPermissionDeniedForeverException {
      return left(LocationPermissionDeniedForeverFailure());
    } catch (_) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, LocationPermissionStatus>> checkLocationPermission() async {
    try {
      final status = await locationDataSource.checkLocationPermission();
      return right(status);
    } catch (_) {
      return left(UnknownFailure());
    }
  }

  /*
  @override
  Future<Either<Failure, LocationPermissionStatus>> checkLocationPermission() async {
    /*try {
      await remoteLocationDataSource.checkLocationPermission();
      return right(unit);
    } on Exception catch (_) {
      return left(LocationFailure());
    }*/
  }
  /*
  // True if difference is more than 3 hours
  bool _isLocationExpired(DateTime savedAt) {
    return DateTime.now().difference(savedAt).inHours > 3;
  }*/*/
}
