part of 'reading_cubit.dart';

abstract class ReadingState {}

class ReadingInitial extends ReadingState {}

class ReadingLoading extends ReadingState {}

class ReadingSuccess extends ReadingState {
  final ReadingEntity reading;
  final List<ReadingEntity> history;

  ReadingSuccess({
    required this.reading,
    required this.history,
  });
}

class ReadingError extends ReadingState {
  final String message;

  ReadingError(this.message);
}