import 'package:flutter_weather_app/core/common/utils/format_date.dart';
import 'package:flutter_weather_app/features/weather/data/models/coordinates_model.dart';
import 'package:flutter_weather_app/features/weather/data/models/main_temp_model.dart';
import 'package:flutter_weather_app/features/weather/data/models/main_weather_model.dart';
import 'package:flutter_weather_app/core/common/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.mainWeather,
    required super.coordinates,
    required super.mainTemp,
    required super.country,
    required super.city,
    required super.dt,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> map) {
    // main weather
    final mainWeatherList = map['weather'] as List<dynamic>?;
    final mainWeatherJson = (mainWeatherList != null && mainWeatherList.isNotEmpty) ? mainWeatherList.first as Map<String, dynamic> : null;
    // main temp
    final mainTempJson = map['main'] as Map<String, dynamic>?;
    // coordintates
    final coordinatesJson = map['coord'] as Map<String, dynamic>?;
    // dt
    final dtJson = map['dt'] as int?;
    // country
    final sysJson = map['sys'] as Map<String, dynamic>?;

    return WeatherModel(
      mainWeather: mainWeatherJson != null ? MainWeatherModel.fromJson(mainWeatherJson) : null,
      mainTemp: mainTempJson != null ? MainTempModel.fromJson(mainTempJson) : null,
      coordinates: coordinatesJson != null ? CoordinatesModel.fromJson(coordinatesJson) : null,
      dt: dtJson != null ? formatDateByUnixTimeToYMMMD(dtJson) : null,
      country: sysJson?['country'] as String?,
      city: map['name'] as String?,
    );
  }
}
