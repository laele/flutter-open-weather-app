import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/core/theme/app_theme.dart';
import 'package:flutter_weather_app/features/weather/presentation/screens/weather_screen.dart';
import 'package:flutter_weather_app/features/weather/presentation/weather_bloc/weather_bloc.dart';
import 'package:flutter_weather_app/features/location/presentation/location_bloc/location_bloc.dart';
import 'package:flutter_weather_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<WeatherBloc>()), // get cache weather
        BlocProvider(create: (context) => serviceLocator<LocationBloc>()..add(LocationStatusChecked())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return /*BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) =>*/ MaterialApp(
      theme: ThemeData.dark().copyWith(),
      home: const WeatherScreen(),
    );
    //);
  }
}
