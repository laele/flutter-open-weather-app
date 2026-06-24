part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {}

class LocationStatusChecked extends LocationEvent {
  @override
  List<Object?> get props => [];
}

class LocationPermissionRequested extends LocationEvent {
  @override
  List<Object?> get props => [];
}

class LocationRefreshRequested extends LocationEvent {
  @override
  List<Object?> get props => [];
}
