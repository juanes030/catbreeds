import 'package:equatable/equatable.dart';
import 'package:catbreeds/features/breeds/domain/entities/breed_image.dart';
import 'package:catbreeds/features/breeds/domain/entities/breed_measurement.dart';

class Breed extends Equatable {
  final String id;
  final String name;
  final String lifeSpan;
  final String temperament;
  final String origin;
  final String description;
  final String history;
  final BreedMeasurement weight;
  final BreedMeasurement height;
  final BreedImage? image;

  const Breed({
    required this.id,
    required this.name,
    required this.lifeSpan,
    required this.temperament,
    required this.origin,
    required this.description,
    required this.history,
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
