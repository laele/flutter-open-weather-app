part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class WeatherGetByCoordinates extends WeatherEvent {
  final CoordinatesEntity coordinates;
  WeatherGetByCoordinates({required this.coordinates});
}

final class WeatherGetByCityName extends WeatherEvent {
  final String city;
  WeatherGetByCityName({required this.city});
}
