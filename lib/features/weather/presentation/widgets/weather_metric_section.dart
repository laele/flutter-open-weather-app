import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/common/constants/app_spacing.dart';
import 'package:flutter_weather_app/core/theme/app_shadows.dart';
import 'package:flutter_weather_app/features/weather/presentation/weather_bloc/weather_bloc.dart';
import 'package:flutter_weather_app/features/weather/presentation/weather_bloc/weather_state.dart';

class WeatherMetricSection extends StatelessWidget {
  const WeatherMetricSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WeatherBloc, WeatherState, ({double? feelsLike, int? humidity, int? pressure})>(
      selector: (state) => (
        feelsLike: state.weather?.mainTemp?.feelsLike,
        humidity: state.weather?.mainTemp?.humidity,
        pressure: state.weather?.mainTemp?.pressure,
      ),
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _WeatherMetricCard(icon: Icons.thermostat, title: 'feels like', value: state.feelsLike != null ? '${state.feelsLike}°' : '--°'),
          _WeatherMetricCard(icon: Icons.water_drop, title: 'humidity', value: state.humidity != null ? '${state.humidity}%' : '--%'),
          _WeatherMetricCard(icon: Icons.speed, title: 'pressure', value: state.pressure != null ? '${state.pressure}' : '--'),
        ],
      ),
    );
  }
}

class _WeatherMetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _WeatherMetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppShadows.weatherCard,
      ),
      child: Column(
        children: [
          Icon(icon),
          SizedBox(height: AppSpacing.xs),
          Text(value),
          SizedBox(height: AppSpacing.xs),
          Text(title),
        ],
      ),
    );
  }
}
