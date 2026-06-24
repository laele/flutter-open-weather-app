import 'package:flutter_weather_app/features/weather/domain/entities/main_temp_entity.dart';

class MainTempModel extends MainTempEntity {
  MainTempModel({
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.seaLevel,
    required super.grindLevel,
    required super.humidity,
    required super.tempKf,
  });

  factory MainTempModel.fromJson(Map<String, dynamic> map) {
    return MainTempModel(
      temp: (map['temp'] as num?)?.toDouble(),
      feelsLike: (map['feels_like'] as num?)?.toDouble(),
      tempMin: (map['temp_min'] as num?)?.toDouble(),
      tempMax: (map['temp_max'] as num?)?.toDouble(),
      pressure: map['pressure'] as int?,
      seaLevel: map['sea_level'] as int?,
      grindLevel: map['grnd_level'] as int?,
      humidity: map['humidity'] as int?,
      tempKf: (map['temp_kf'] as num?)?.toDouble(),
    );
  }
}
