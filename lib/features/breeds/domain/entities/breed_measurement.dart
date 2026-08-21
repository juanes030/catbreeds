import 'package:equatable/equatable.dart';

class BreedMeasurement extends Equatable {
  final String imperial;
  final String metric;

  const BreedMeasurement({required this.imperial, required this.metric});

  @override
  List<Object?> get props => [imperial, metric];
}
