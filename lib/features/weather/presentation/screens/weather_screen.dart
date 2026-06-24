import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/common/constants/app_spacing.dart';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/features/weather/presentation/views/weather_view.dart';
import 'package:flutter_weather_app/features/weather/presentation/weather_bloc/weather_bloc.dart';
import 'package:flutter_weather_app/features/weather/presentation/weather_bloc/weather_state.dart';
import 'package:flutter_weather_app/features/location/presentation/location_bloc/location_bloc.dart';
import 'package:flutter_weather_app/features/location/presentation/location_bloc/location_state.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WeatherBloc, WeatherState>(
          listenWhen: (previous, current) => previous.status != current.status && current.status == WeatherStatus.failure,
          listener: (BuildContext context, WeatherState state) {
            // Show Location status failure message
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  persist: true,
                ),
              );
          },
        ),
        BlocListener<LocationBloc, LocationState>(
          listenWhen: (previous, current) => !previous.isFailure && current.isFailure,
          listener: (BuildContext context, LocationState state) {
            // Show Location status failure message
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  persist: true,
                ),
              );
          },
        ),
        BlocListener<LocationBloc, LocationState>(
          listenWhen: (previous, current) => current.isGranted && previous.fetchedAt != current.fetchedAt,
          listener: (BuildContext context, LocationState state) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.read<WeatherBloc>().add(WeatherGetByCoordinates(coordinates: state.coordinates!));
          },
        ),
      ],
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              centerTitle: true,
              title: BlocSelector<WeatherBloc, WeatherState, ({String? city, String? country})>(
                selector: (state) => (city: state.weather?.city, country: state.weather?.country),
                builder: (context, state) => Text('${state.city ?? '--'}, ${state.country ?? '--'}'),
              ),
              actions: [
                /*IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),*/
              ],
            ),
            body: WeatherView(),
            floatingActionButton: _WeatherRefreshButton(),
          ),
          BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              final shouldShow = state.isFailure;
              if (shouldShow) {
                return Positioned.fill(
                  child: ColoredBox(
                    color: Colors.black.withValues(alpha: 0.6),
                    child: Center(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Please Enable / Allow Location Services'),
                              SizedBox(
                                height: AppSpacing.md,
                              ),
                              FilledButton(
                                onPressed: () {
                                  switch (state.status) {
                                    case LocationStatus.denied:
                                      context.read<LocationBloc>().add(LocationPermissionRequested());
                                      break;
                                    case LocationStatus.deniedForever:
                                      Geolocator.openAppSettings();
                                      break;
                                    case LocationStatus.serviceDisabled:
                                      Geolocator.openLocationSettings();
                                      break;
                                    case LocationStatus.granted:
                                      context.read<LocationBloc>().add(LocationRefreshRequested());
                                      break;
                                    default:
                                      break;
                                  }
                                },
                                child: Text('Accept'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _WeatherRefreshButton extends StatelessWidget {
  const _WeatherRefreshButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LocationBloc, LocationState, CoordinatesEntity?>(
      selector: (state) {
        return state.coordinates;
      },
      builder: (context, coordinates) {
        return BlocSelector<WeatherBloc, WeatherState, WeatherStatus>(
          selector: (state) => state.status,
          builder: (context, status) {
            final bool canRefresh = status != WeatherStatus.loading && coordinates != null;
            return FloatingActionButton(
              backgroundColor: canRefresh ? Colors.blue : Colors.grey,
              onPressed: canRefresh
                  ? () {
                      final weatherStatus = context.read<WeatherBloc>().state.status;
                      final coordinates = context.read<LocationBloc>().state.coordinates;

                      if (coordinates != null && weatherStatus != WeatherStatus.loading) {
                        context.read<WeatherBloc>().add(WeatherGetByCoordinates(coordinates: coordinates));
                      }
                    }
                  : null,
              child: canRefresh
                  ? Icon(Icons.refresh)
                  : SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                        strokeWidth: 3,
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
