import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/core/common/entities/coordinates_entity.dart';
import 'package:flutter_weather_app/features/location/domain/repositories/location_repository.dart';
import 'package:flutter_weather_app/core/error/failures.dart';
import 'package:flutter_weather_app/core/usecase/usecase.dart';

class GetCurrentLocationUseCase implements UseCase<CoordinatesEntity, NoParams> {
  final LocationRepository locationRepository;
  GetCurrentLocationUseCase({required this.locationRepository});

  @override
  Future<Either<Failure, CoordinatesEntity>> call(NoParams params) async {
    return await locationRepository.getCurrentLocation();
  }
}
