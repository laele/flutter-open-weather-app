import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/core/error/failures.dart';
import 'package:flutter_weather_app/features/location/domain/enums/location_permission_status.dart';

abstract interface class LocationRepository {
  Future<Either<Failure, LocationPermissionStatus>> checkLocationPermission();
  Future<Either<Failure, CoordinatesEntity>> getCurrentLocation();
}
