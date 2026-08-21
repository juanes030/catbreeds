import 'package:catbreeds/features/breeds/domain/entities/breed_measurement.dart';

class BreedMeasurementModel extends BreedMeasurement {
  const BreedMeasurementModel({required super.imperial, required super.metric});

  factory BreedMeasurementModel.fromJson(Map<String, dynamic> json) {
    return BreedMeasurementModel(
      imperial: json['imperial'] as String,
      metric: json['metric'] as String,
    );
  }
}
