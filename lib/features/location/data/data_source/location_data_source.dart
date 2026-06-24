import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/core/error/exceptions.dart';
import 'package:flutter_weather_app/features/location/domain/enums/location_permission_status.dart';
import 'package:geolocator/geolocator.dart' hide LocationServiceDisabledException;

abstract interface class LocationDataSource {
  Future<CoordinatesEntity> getCurrentLocation();
  Future<LocationPermissionStatus> checkLocationPermission();
}

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<LocationPermissionStatus> checkLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return LocationPermissionStatus.serviceDisabled;

    final permission = await Geolocator.checkPermission();

    return switch (permission) {
      LocationPermission.always => LocationPermissionStatus.granted,
      LocationPermission.whileInUse => LocationPermissionStatus.granted,
      LocationPermission.denied => LocationPermissionStatus.denied,
      LocationPermission.deniedForever => LocationPermissionStatus.deniedForever,
      _ => LocationPermissionStatus.denied,
    };
  }

  Future<CoordinatesEntity> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw LocationServiceDisabledException();

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedForeverException();
    }

    final position = await Geolocator.getCurrentPosition();

    return CoordinatesEntity(latitude: position.latitude, longitude: position.longitude);
  }
}
