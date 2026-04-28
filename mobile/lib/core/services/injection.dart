import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../connection/network_info.dart';
import '../../features/readings/data/datasources/reading_remote_datasource.dart';
import '../../features/readings/data/repositories/reading_repository_impl.dart';
import '../../features/readings/domain/repositories/reading_repository.dart';
import '../../features/readings/domain/usecases/get_latest_reading_usecase.dart';
import '../../features/readings/presentation/cubit/reading_cubit.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';

final getIt = GetIt.instance;
void initGetIt() {
  //! constants
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(
      dio: Dio(),
    ),
  );
    getIt.registerLazySingleton(() => DataConnectionChecker());

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<DataConnectionChecker>()),
  );

  //! Readings

  // Data Layer
  getIt.registerLazySingleton(
    () => ReadingRemoteDataSource(api: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<ReadingRepository>(
    () => ReadingRepositoryImpl(
      readingRemoteDataSource: getIt<ReadingRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  // Domain Layer
  getIt.registerLazySingleton(
    () => GetLatestReadingUsecase(repository: getIt<ReadingRepository>()),
  );
  // Presentation Layer
  getIt.registerFactory(() => ReadingCubit());
}
