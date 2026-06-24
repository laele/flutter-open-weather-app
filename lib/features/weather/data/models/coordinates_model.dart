import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';

class CoordinatesModel extends CoordinatesEntity {
  CoordinatesModel({required super.latitude, required super.longitude});

  factory CoordinatesModel.fromJson(Map<String, dynamic> map) {
    return CoordinatesModel(
      latitude: (map['lat'] as num?)?.toDouble(),
      longitude: (map['lon'] as num?)?.toDouble(),
    );
  }
}
