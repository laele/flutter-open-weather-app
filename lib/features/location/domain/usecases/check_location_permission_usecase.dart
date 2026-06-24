import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/error/failures.dart';
import 'package:flutter_weather_app/core/usecase/usecase.dart';
import 'package:flutter_weather_app/features/location/domain/enums/location_permission_status.dart';
import 'package:flutter_weather_app/features/location/domain/repositories/location_repository.dart';

class CheckLocationPermissionUseCase implements UseCase<LocationPermissionStatus, NoParams> {
  final LocationRepository locationRepository;
  CheckLocationPermissionUseCase({required this.locationRepository});

  @override
  Future<Either<Failure, LocationPermissionStatus>> call(NoParams params) async {
    return locationRepository.checkLocationPermission();
  }
}
