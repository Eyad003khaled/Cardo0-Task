import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/endpoints.dart';
import '../../../../../core/errors/error_model.dart';
import '../../../../../core/errors/exceptions.dart';

import '../models/reading_model.dart';

class ReadingRemoteDataSource {
  final ApiConsumer api;

  ReadingRemoteDataSource({required this.api});

  Future<ReadingModel> getLatestReading() async {
    try {
      final response = await api.get(Endpoints.latestReading);

      // Parse response into `ReadingModel`
      return ReadingModel.fromJson(response);
    } catch (error) {
      throw ServerException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to fetch Reading: ${error.toString()}',
          status: false,
        ),
      );
    }
  }
}
