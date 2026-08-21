import 'package:flutter/material.dart';
import 'package:catbreeds/features/breeds/domain/entities/breed.dart';

class BreedCard extends StatelessWidget {
  final Breed breed;

  const BreedCard({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    final origin = breed.origin ?? 'Origin unknown';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: _BreedImage(imageUrl: breed.image?.url),
        title: Text(breed.name),
        subtitle: Text(origin),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _BreedImage extends StatelessWidget {
  final String? imageUrl;

  const _BreedImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const CircleAvatar(child: Icon(Icons.pets));
    }

    return CircleAvatar(backgroundImage: NetworkImage(imageUrl!));
  }
}
