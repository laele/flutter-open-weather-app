import 'package:flutter_weather_app/features/weather/domain/entities/main_temp_entity.dart';
import 'package:flutter_weather_app/features/weather/domain/entities/main_weather_entity.dart';

class HourlyWeatherEntity {
  final String dt;
  final String hour;
  final List<MainWeatherEntity> weatherList;
  final MainTempEntity mainTemp;
  HourlyWeatherEntity({required this.dt, required this.hour, required this.weatherList, required this.mainTemp});
}
