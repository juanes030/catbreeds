import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:flutter/material.dart';

class BreedCard extends StatelessWidget {
  final Breed breed;
  final VoidCallback? onTap;

  const BreedCard({super.key, required this.breed, this.onTap});

  @override
  Widget build(BuildContext context) {
    final origin = breed.origin?.isNotEmpty == true
        ? breed.origin!
        : 'Origin unknown';

    final isIntelligent =
        breed.temperament?.toLowerCase().contains('intelligent') ?? false;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      breed.name,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Más...',
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            _BreedImage(imageUrl: breed.image?.url),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: _BreedInfo(label: 'País de origen', value: origin),
                  ),
                  Expanded(
                    child: _BreedInfo(
                      label: 'Inteligencia',
                      value: isIntelligent ? 'Intelligent' : 'Unknown',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreedInfo extends StatelessWidget {
  final String label;
  final String value;

  const _BreedInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _BreedImage extends StatelessWidget {
  final String? imageUrl;

  const _BreedImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.45,
      child: imageUrl == null || imageUrl!.isEmpty
          ? const ColoredBox(
              color: Color(0xFFF2F2F2),
              child: Center(child: Icon(Icons.pets, size: 64)),
            )
          : Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) {
                  return child;
                }

                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                  child: child,
                );
              },
              errorBuilder: (_, _, _) {
                return const ColoredBox(
                  color: Color(0xFFF2F2F2),
                  child: Center(
                    child: Icon(Icons.broken_image_outlined, size: 48),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const ColoredBox(
                  color: Color(0xFFF2F2F2),
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            )
    );
  }
}
