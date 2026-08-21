import 'package:catbreeds/features/breeds/domain/entities/breed_image.dart';

class BreedImageModel extends BreedImage {
  const BreedImageModel({
    required super.id,
    required super.url,
    required super.width,
    required super.height,
  });

  factory BreedImageModel.fromJson(Map<String, dynamic> json) {
    return BreedImageModel(
      id: json['id'] as String,
      url: json['url'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );
  }
}
