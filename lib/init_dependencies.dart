import 'package:dio/dio.dart';
import 'package:flutter_weather_app/features/location/domain/usecases/check_location_permission_usecase.dart';
import 'package:flutter_weather_app/features/location/presentation/location_bloc/location_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_weather_app/features/location/data/data_source/location_data_source.dart';
import 'package:flutter_weather_app/features/location/data/repositories/location_repository_impl.dart';
import 'package:flutter_weather_app/features/location/domain/repositories/location_repository.dart';
import 'package:flutter_weather_app/features/location/domain/usecases/get_current_location_usecase.dart';
import 'package:flutter_weather_app/features/weather/data/data_source/weather_remote_data_source.dart';
import 'package:flutter_weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_weather_app/features/weather/domain/usecases/get_weather_by_coordinates_usecase.dart';
import 'package:flutter_weather_app/features/weather/presentation/weather_bloc/weather_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Hive
  /*await Hive.initFlutter();
  Hive.registerAdapter(LocationHiveModelAdapter());
  final locationBox = await Hive.openBox<LocationHiveModel>('location_box');*/
  //

  // Dio
  final dioClient = Dio();
  serviceLocator.registerLazySingleton<Dio>(() => dioClient);
  //

  _initLocation();
  _initWeather();
}

void _initLocation() {
  serviceLocator
    ..registerFactory<LocationDataSource>(() => LocationDataSourceImpl())
    ..registerFactory<LocationRepository>(() => LocationRepositoryImpl(locationDataSource: serviceLocator()))
    ..registerFactory<GetCurrentLocationUseCase>(() => GetCurrentLocationUseCase(locationRepository: serviceLocator()))
    ..registerFactory<CheckLocationPermissionUseCase>(() => CheckLocationPermissionUseCase(locationRepository: serviceLocator()))
    ..registerFactory<LocationBloc>(() => LocationBloc(checkLocationPermissionUseCase: serviceLocator(), getCurrentLocationUseCase: serviceLocator()));
}

void _initWeather() {
  serviceLocator
    ..registerFactory<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImpl(dioClient: serviceLocator()))
    ..registerFactory<WeatherRepository>(() => (WeatherRepositoryImpl(weatherRemoteDataSource: serviceLocator())))
    // Use Cases
    ..registerFactory<GetWeatherByCoordinatesUseCase>(() => GetWeatherByCoordinatesUseCase(weatherRepository: serviceLocator()))
    //..registerFactory(() => GetHourlyWeatherUseCase(weatherRepository: serviceLocator()))
    // bLoc
    ..registerFactory(() => WeatherBloc(getWeatherByCoordinatesUseCase: serviceLocator()));
  //..registerFactory(() => HourlyWeatherBloc(getHourlyWeatherUseCase: serviceLocator()));
}
