import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/injection.dart';
import '../../domain/entities/reading_entity.dart';
import '../../domain/usecases/get_latest_reading_usecase.dart';

part 'reading_state.dart';

class ReadingCubit extends Cubit<ReadingState> {
  final GetLatestReadingUsecase getLatestReadingUsecase;

  ReadingCubit()
      : getLatestReadingUsecase = getIt<GetLatestReadingUsecase>(),
        super(ReadingInitial());

  /// 🔁 Timer for auto refresh
  Timer? _timer;

  /// 📊 Store last readings (for chart)
  final List<ReadingEntity> _history = [];

  List<ReadingEntity> get history => List.unmodifiable(_history);

  /// 🚀 Fetch latest reading
  Future<void> fetchReading() async {
    // 🔥 Optional: avoid flicker if already has data
    if (state is! ReadingSuccess) {
      emit(ReadingLoading());
    }

    final result = await getLatestReadingUsecase();

    result.fold(
      (failure) => emit(ReadingError(failure.errMessage)),
      (reading) {
        /// 📊 Update history
        _history.add(reading);

        /// Keep only last 10 readings
        if (_history.length > 10) {
          _history.removeAt(0);
        }

        emit(ReadingSuccess(
          reading: reading,
          history: List.from(_history),
        ));
      },
    );
  }

  /// 🔄 Start auto refresh every 5 seconds
  void startAutoRefresh() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      fetchReading();
    });
  }

  /// 🛑 Stop timer when cubit is closed
  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}