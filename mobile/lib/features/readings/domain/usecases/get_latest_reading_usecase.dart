// domain/usecases/get_latest_reading_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/reading_entity.dart';
import '../repositories/reading_repository.dart';

class GetLatestReadingUsecase {
  final ReadingRepository repository;

  GetLatestReadingUsecase({required this.repository});

  Future<Either<Failure, ReadingEntity>> call() {
    return repository.getLatestReading();
  }
}
