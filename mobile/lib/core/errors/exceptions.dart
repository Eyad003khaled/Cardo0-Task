import 'package:dio/dio.dart';

import 'error_model.dart';


//! Server Exception
class ServerException implements Exception {
  final ErrorModel errorModel;
  final int? statusCode;

  ServerException({required this.errorModel, this.statusCode});
}


//!CacheExeption
class CacheException implements Exception {
  final String errorMessage;
  CacheException({required this.errorMessage});
}



void handleDioExceptions(DioException e) {
  final responseData = e.response?.data ?? {};
  final statusCode = e.response?.statusCode;

  final errorModel = ErrorModel.fromJson(responseData);

  throw ServerException(
    errorModel: errorModel,
    statusCode: statusCode,
  );
}
