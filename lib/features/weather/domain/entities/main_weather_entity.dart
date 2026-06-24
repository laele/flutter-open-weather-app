import 'package:equatable/equatable.dart';

class MainWeatherEntity extends Equatable {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  const MainWeatherEntity({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, main, description, icon];
}
