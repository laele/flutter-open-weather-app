import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/features/weather/presentation/weather_bloc/weather_bloc.dart';
import 'package:flutter_weather_app/features/weather/presentation/weather_bloc/weather_state.dart';

class WeatherMainSection extends StatelessWidget {
  const WeatherMainSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WeatherBloc, WeatherState, ({double? temp, String? mainWeather, String? date, WeatherStatus status})>(
      selector: (state) => (date: state.weather?.dt, mainWeather: state.weather?.mainWeather?.main, temp: state.weather?.mainTemp?.temp, status: state.status),
      builder: (context, state) => Column(
        children: [
          Text(
            '${state.status}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            state.temp != null ? '${state.temp}°' : '--°',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            state.mainWeather != null ? '${state.mainWeather}' : '--',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            state.date != null ? '${state.date}' : '----',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
