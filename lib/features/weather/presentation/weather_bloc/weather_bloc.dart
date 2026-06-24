import 'dart:async';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/features/weather/presentation/weather_bloc/weather_state.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_weather_app/features/weather/domain/usecases/get_weather_by_coordinates_usecase.dart';

part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherByCoordinatesUseCase _getWeatherByCoordinatesUseCase;

  WeatherBloc({required GetWeatherByCoordinatesUseCase getWeatherByCoordinatesUseCase})
    : _getWeatherByCoordinatesUseCase = getWeatherByCoordinatesUseCase,
      super(WeatherState.initial()) {
    on<WeatherGetByCoordinates>(_onWeatherGetByCoordinates);
    on<WeatherGetByCityName>(_onWeatherGetByCityName);
  }

  FutureOr<void> _onWeatherGetByCoordinates(WeatherGetByCoordinates event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    await Future.delayed(Duration(seconds: 2));

    final result = await _getWeatherByCoordinatesUseCase.call(event.coordinates);

    result.fold(
      (failure) => emit(state.copyWith(status: WeatherStatus.failure, errorMessage: failure.message)),
      (weather) => emit(
        state.copyWith(weather: weather, status: WeatherStatus.success),
      ),
    );
  }

  FutureOr<void> _onWeatherGetByCityName(WeatherGetByCityName event, Emitter<WeatherState> emit) {}
}
