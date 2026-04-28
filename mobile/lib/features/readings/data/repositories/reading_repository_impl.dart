// data/repositories/reading_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../connection/network_info.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/functions/toast/custom_toast.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/reading_entity.dart';
import '../../domain/repositories/reading_repository.dart';
import '../datasources/reading_remote_datasource.dart';

class ReadingRepositoryImpl implements ReadingRepository {
  final ReadingRemoteDataSource readingRemoteDataSource;
  final NetworkInfo networkInfo;

  ReadingRepositoryImpl(
      {required this.networkInfo, required this.readingRemoteDataSource});

  @override
  Future<Either<Failure, ReadingEntity>> getLatestReading() async {
    try {
      final isConnected = await networkInfo.isConnected ?? false;
      if (isConnected) {
        final result = await readingRemoteDataSource.getLatestReading();
        
        return Right(result);
      }
      else{
                // Handle case where the user is offline
        showToast(
          false,
          AppStrings.noInternetTitle,
          AppStrings.noInternetSubtitle,
        );
        return Left(Failure(errMessage: AppStrings.noInternetSubtitle));
      }
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return Left(Failure(errMessage: 'Unexpected error: ${e.toString()}'));
    }
  }
}
