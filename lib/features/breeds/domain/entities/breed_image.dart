import 'package:equatable/equatable.dart';

class BreedImage extends Equatable {
  final String id;
  final String url;
  final int width;
  final int height;

  const BreedImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [id, url, width, height];
}
