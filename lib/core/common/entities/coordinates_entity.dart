import 'package:equatable/equatable.dart';

class CoordinatesEntity extends Equatable {
  final double? latitude;
  final double? longitude;
  const CoordinatesEntity({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
