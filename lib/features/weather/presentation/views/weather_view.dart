import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/common/constants/app_spacing.dart';
import 'package:flutter_weather_app/features/weather/presentation/widgets/weather_metric_section.dart';
import 'package:flutter_weather_app/features/weather/presentation/widgets/weather_location_section.dart';
import 'package:flutter_weather_app/features/weather/presentation/widgets/weather_main_section.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32.0),
                ),
              ),
              child: Column(
                children: [
                  WeatherLocationSection(),
                  SizedBox(height: AppSpacing.md),
                  Spacer(),
                  WeatherMainSection(),

                  SizedBox(height: AppSpacing.md),
                  Spacer(),
                  WeatherMetricSection(),
                  SizedBox(height: AppSpacing.md),
                ],
              ), // tamaño natural
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
        ),
      ],
    );
  }
}
