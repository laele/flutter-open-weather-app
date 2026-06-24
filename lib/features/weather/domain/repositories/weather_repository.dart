import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/core/error/failures.dart';
import 'package:flutter_weather_app/core/common/entities/weather_entity.dart';

abstract interface class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeatherByCoordinates({required CoordinatesEntity coordinates});
}
