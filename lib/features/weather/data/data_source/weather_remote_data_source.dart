import 'package:dio/dio.dart';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/core/common/mappers/dio_exception_mapper.dart';
import 'package:flutter_weather_app/core/error/exceptions.dart';
import 'package:flutter_weather_app/features/weather/data/models/weather_model.dart';
import 'package:flutter_weather_app/secrets.dart';

abstract interface class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherByCoordinates({required CoordinatesEntity coordinates});
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dioClient;
  WeatherRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<WeatherModel> getWeatherByCoordinates({required CoordinatesEntity coordinates}) async {
    try {
      final response = await dioClient.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'lat': coordinates.latitude,
          'lon': coordinates.longitude,
          'units': 'metric',
          'appid': Secrets.openWeatherApiKey,
        },
      );
      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      throw mapDioException(e);
    } on TypeError catch (e) {
      throw ParsingException(message: 'Response processing error: $e');
    } on FormatException catch (e) {
      throw ParsingException(message: 'Invalid response format: $e');
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
