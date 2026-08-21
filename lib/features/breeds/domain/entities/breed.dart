import 'package:catbreeds/features/breeds/domain/entities/breed_image.dart';
import 'package:catbreeds/features/breeds/domain/entities/breed_measurement.dart';
import 'package:equatable/equatable.dart';

class Breed extends Equatable {
  final String id;
  final String name;
  final String? lifeSpan;
  final String? temperament;
  final String? origin;
  final String? description;
  final String? history;
  final BreedMeasurement weight;
  final BreedMeasurement height;
  final BreedImage? image;

  const Breed({
    required this.id,
    required this.name,
    this.lifeSpan,
    this.temperament,
    this.origin,
    this.description,
    this.history,
    required this.weight,
    required this.height,
    this.image,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    lifeSpan,
    temperament,
    origin,
    description,
    history,
    weight,
    height,
    image,
  ];
}
