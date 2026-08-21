import 'package:catbreeds/features/breeds/data/models/breed_image_model.dart';
import 'package:catbreeds/features/breeds/data/models/breed_measurement_model.dart';
import 'package:catbreeds/features/breeds/domain/entities/breed.dart';

class BreedModel extends Breed {
  const BreedModel({
    required super.id,
    required super.name,
    required super.lifeSpan,
    required super.temperament,
    required super.origin,
    required super.description,
    required super.history,
    required super.weight,
    required super.height,
    super.image,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'] as String,
      name: json['name'] as String,
      lifeSpan: json['life_span'] as String,
      temperament: json['temperament'] as String,
      origin: json['origin'] as String,
      description: json['description'] as String,
      history: json['history'] as String,
      weight: BreedMeasurementModel.fromJson(
        json['weight'] as Map<String, dynamic>,
      ),
      height: BreedMeasurementModel.fromJson(
        json['height'] as Map<String, dynamic>,
      ),
      image: json['image'] != null
          ? BreedImageModel.fromJson(json['image'] as Map<String, dynamic>)
          : null,
    );
  }
}
