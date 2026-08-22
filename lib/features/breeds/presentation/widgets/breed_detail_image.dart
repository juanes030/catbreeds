import 'package:flutter/material.dart';

class BreedDetailImage extends StatelessWidget {
  final String? imageUrl;

  const BreedDetailImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: double.infinity,
        height: 240,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Icon(Icons.pets, size: 64),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Icon(Icons.broken_image_outlined, size: 64),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
