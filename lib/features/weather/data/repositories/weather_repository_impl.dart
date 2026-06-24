import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/core/error/exceptions.dart';
import 'package:flutter_weather_app/core/error/failures.dart';
import 'package:flutter_weather_app/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:flutter_weather_app/core/common/entities/weather_entity.dart';
import 'package:flutter_weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherByCoordinates({required CoordinatesEntity coordinates}) async {
    try {
      final weather = await weatherRemoteDataSource.getWeatherByCoordinates(coordinates: coordinates);

      // TODO Save in cache

      return right(weather);
    } on NetworkException catch (e) {
      return left(NetworkFailure(message: e.message));
    } on ServerException catch (e) {
      return left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NotFoundException catch (_) {
      return left(ServerFailure(message: 'City not found.'));
    } on ParsingException catch (e) {
      return left(ServerFailure(message: e.message));
    } on UnknownException catch (e) {
      return left(UnknownFailure(message: e.message));
    }
  }
}
