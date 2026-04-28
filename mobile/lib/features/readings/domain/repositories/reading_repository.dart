import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/reading_entity.dart';

abstract class ReadingRepository {
  Future<Either<Failure, ReadingEntity>> getLatestReading();
}