import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';

enum LocationStatus { initial, loading, granted, denied, deniedForever, serviceDisabled }

final class LocationState extends Equatable {
  final LocationStatus status;
  final CoordinatesEntity? coordinates;
  final DateTime? fetchedAt;

  const LocationState({
    this.status = LocationStatus.initial,
    this.coordinates,
    this.fetchedAt,
  });

  factory LocationState.initial() {
    return LocationState(
      fetchedAt: DateTime.now(),
      status: LocationStatus.initial,
    );
  }

  bool get hasCoordinates => coordinates != null;
  bool get isGranted => status == LocationStatus.granted;
  bool get isFailure {
    return switch (status) {
      LocationStatus.denied => true,
      LocationStatus.deniedForever => true,
      LocationStatus.serviceDisabled => true,
      _ => false,
    };
  }

  String? get errorMessage => switch (status) {
    LocationStatus.denied => 'Location Services are denied - Showing up last saved data.',
    LocationStatus.deniedForever => 'Location Services are denied forever - Showing up last saved data.',
    LocationStatus.serviceDisabled => 'Location Services are disabled - Showing up last saved data.',
    _ => null,
  };

  LocationState copyWith({
    LocationStatus? status,
    CoordinatesEntity? coordinates,
    DateTime? fetchedAt,
  }) => LocationState(status: status ?? this.status, coordinates: coordinates ?? this.coordinates, fetchedAt: fetchedAt ?? this.fetchedAt);

  @override
  List<Object?> get props => [status, coordinates, fetchedAt];
}
