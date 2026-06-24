import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/features/weather/domain/entities/main_temp_entity.dart';
import 'package:flutter_weather_app/features/weather/domain/entities/main_weather_entity.dart';

class WeatherEntity {
  final String? dt;
  final MainTempEntity? mainTemp;
  final CoordinatesEntity? coordinates;
  final MainWeatherEntity? mainWeather;
  final String? city;
  final String? country;

  WeatherEntity({
    required this.coordinates,
    required this.mainWeather,
    required this.dt,
    required this.country,
    required this.city,
    required this.mainTemp,
  });
}
