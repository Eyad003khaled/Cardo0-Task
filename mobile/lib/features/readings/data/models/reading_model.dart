// data/models/reading_model.dart
import 'package:mobile/features/readings/domain/entities/reading_entity.dart';


class ReadingModel extends ReadingEntity {
  ReadingModel({
    required super.temperature,
    required super.humidity,
    required super.createdAt,
  });

  factory ReadingModel.fromJson(Map<String, dynamic> json) {
    return ReadingModel(
      temperature: (json['temperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
    );
  }
}