import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/features/location/presentation/location_bloc/location_bloc.dart';
import 'package:flutter_weather_app/features/location/presentation/location_bloc/location_state.dart';

class WeatherLocationSection extends StatelessWidget {
  const WeatherLocationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LocationBloc, LocationState, ({LocationStatus? status, CoordinatesEntity? coordinates})>(
      selector: (state) => (
        status: state.status,
        coordinates: state.coordinates,
      ),
      builder: (context, state) => Column(
        children: [
          Text('location status: ${state.status!.name}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(state.coordinates?.latitude != null ? 'lat: ${state.coordinates!.latitude.toString()}' : 'lat: --'),
              Text(state.coordinates?.longitude != null ? 'lon: ${state.coordinates!.longitude.toString()}' : 'lon: --'),
            ],
          ),
        ],
      ),
    );
  }
}
