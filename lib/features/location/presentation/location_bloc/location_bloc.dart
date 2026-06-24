import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/error/failures.dart';
import 'package:flutter_weather_app/core/usecase/usecase.dart';
import 'package:flutter_weather_app/features/location/domain/enums/location_permission_status.dart';
import 'package:flutter_weather_app/features/location/domain/usecases/check_location_permission_usecase.dart';
import 'package:flutter_weather_app/features/location/domain/usecases/get_current_location_usecase.dart';
import 'package:flutter_weather_app/features/location/presentation/location_bloc/location_state.dart';
part 'location_event.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> with WidgetsBindingObserver {
  // Watch Life Cycle
  final CheckLocationPermissionUseCase _checkLocationPermissionUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;

  LocationBloc({
    required CheckLocationPermissionUseCase checkLocationPermissionUseCase,
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
  }) : _checkLocationPermissionUseCase = checkLocationPermissionUseCase,
       _getCurrentLocationUseCase = getCurrentLocationUseCase,
       super(LocationState.initial()) {
    WidgetsBinding.instance.addObserver(this);
    on<LocationStatusChecked>(_onLocationStatusChecked);
    on<LocationPermissionRequested>(_onLocationPermissionRequested);
    on<LocationRefreshRequested>(_onLocationRefreshRequested);
  }

  // App Life Cycle - Called when user resume the app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      add(LocationStatusChecked());
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  // Implemented starting app and back from background
  FutureOr<void> _onLocationStatusChecked(LocationStatusChecked event, Emitter<LocationState> emit) async {
    final result = await _checkLocationPermissionUseCase(NoParams());

    await result.fold((failure) async => emit(state.copyWith(status: _statusFromFailure(failure))), (permissionStatus) async {
      if (permissionStatus == LocationPermissionStatus.granted) {
        await _getCurrentLocation(emit);
      } else {
        emit(state.copyWith(status: _statusFromPermission(permissionStatus)));
      }
    });
  }

  FutureOr<void> _onLocationPermissionRequested(LocationPermissionRequested event, Emitter<LocationState> emit) async {
    emit(state.copyWith(status: LocationStatus.loading));
    await _getCurrentLocation(emit);
  }

  // No loading needed - since is a refresh not initial loading
  FutureOr<void> _onLocationRefreshRequested(LocationRefreshRequested event, Emitter<LocationState> emit) async {
    await _getCurrentLocation(emit);
  }

  // private helper - Get Location use case
  Future<void> _getCurrentLocation(Emitter<LocationState> emit) async {
    final result = await _getCurrentLocationUseCase(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: _statusFromFailure(failure))),
      (coordinates) => emit(
        state.copyWith(
          status: LocationStatus.granted,
          coordinates: coordinates,
          fetchedAt: DateTime.now(),
        ),
      ),
    );
  }

  // Location Status Mappers
  LocationStatus _statusFromFailure(Failure failure) => switch (failure) {
    LocationServiceDisabledFailure() => LocationStatus.serviceDisabled,
    LocationPermissionDeniedFailure() => LocationStatus.denied,
    LocationPermissionDeniedForeverFailure() => LocationStatus.deniedForever,
    _ => LocationStatus.denied,
  };

  LocationStatus _statusFromPermission(LocationPermissionStatus permission) => switch (permission) {
    LocationPermissionStatus.granted => LocationStatus.granted,
    LocationPermissionStatus.denied => LocationStatus.denied,
    LocationPermissionStatus.deniedForever => LocationStatus.deniedForever,
    LocationPermissionStatus.serviceDisabled => LocationStatus.serviceDisabled,
  };
}
