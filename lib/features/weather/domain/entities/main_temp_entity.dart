import 'package:equatable/equatable.dart';

class MainTempEntity extends Equatable {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? seaLevel;
  final int? grindLevel;
  final int? humidity;
  final double? tempKf;
  MainTempEntity({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grindLevel,
    required this.humidity,
    required this.tempKf,
  });

  @override
  List<Object?> get props => [
    temp,
    feelsLike,
    tempMin,
    tempMax,
    pressure,
    seaLevel,
    grindLevel,
    humidity,
    tempKf,
  ];
}
