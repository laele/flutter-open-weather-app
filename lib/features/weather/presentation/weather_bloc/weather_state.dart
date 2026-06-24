import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/core/common/entities/weather_entity.dart';

enum WeatherStatus { initial, loading, success, failure }

final class WeatherState extends Equatable {
  final WeatherStatus status;
  final WeatherEntity? weather;
  final String? errorMessage;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
    this.errorMessage,
  });

  factory WeatherState.initial() => WeatherState(
    status: WeatherStatus.initial,
    weather: null,
    errorMessage: null,
  );

  WeatherState copyWith({
    WeatherStatus? status,
    WeatherEntity? weather,
    String? errorMessage,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    weather,
    errorMessage,
  ];
}
