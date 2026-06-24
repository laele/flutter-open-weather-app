import 'package:flutter_weather_app/features/weather/domain/entities/main_weather_entity.dart';

class MainWeatherModel extends MainWeatherEntity {
  const MainWeatherModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  factory MainWeatherModel.fromJson(Map<String, dynamic> map) {
    return MainWeatherModel(
      id: map['id'] as int?,
      main: map['main'] as String?,
      description: map['description'] as String?,
      icon: map['icon'] as String?,
    );
  }
}
