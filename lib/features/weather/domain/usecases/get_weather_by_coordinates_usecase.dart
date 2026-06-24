import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/core/error/failures.dart';
import 'package:flutter_weather_app/core/usecase/usecase.dart';
import 'package:flutter_weather_app/core/common/entities/weather_entity.dart';
import 'package:flutter_weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherByCoordinatesUseCase implements UseCase<WeatherEntity, CoordinatesEntity> {
  final WeatherRepository weatherRepository;
  const GetWeatherByCoordinatesUseCase({required this.weatherRepository});

  @override
  Future<Either<Failure, WeatherEntity>> call(CoordinatesEntity params) async {
    return await weatherRepository.getWeatherByCoordinates(coordinates: params);
  }
}
