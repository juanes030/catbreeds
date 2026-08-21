import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:flutter/material.dart';

class BreedDetailPage extends StatelessWidget {
  final Breed breed;

  const BreedDetailPage({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    final characteristics = _extractCharacteristics(breed.temperament);

    final isIntelligent = characteristics.any(
      (value) => value.toLowerCase() == 'intelligent',
    );

    final isAdaptable = characteristics.any(
      (value) => value.toLowerCase() == 'adaptable',
    );

    return Scaffold(
      appBar: AppBar(title: Text(breed.name)),
      body: Column(
        children: [
          _BreedImage(imageUrl: breed.image?.url),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    breed.name,
                    style: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  _InfoRow(label: 'Origin', value: breed.origin ?? 'Unknown'),

                  _InfoRow(
                    label: 'Life span',
                    value: breed.lifeSpan ?? 'Unknown',
                  ),

                  const SizedBox(height: 24),

                  _SectionTitle(title: 'Characteristics'),

                  const SizedBox(height: 12),

                  _CharacteristicRow(
                    label: 'Intelligence',
                    value: isIntelligent,
                  ),

                  _CharacteristicRow(label: 'Adaptability', value: isAdaptable),

                  const SizedBox(height: 24),

                  _Section(
                    title: 'Temperament',
                    content: breed.temperament ?? 'No information available.',
                  ),

                  _Section(
                    title: 'Description',
                    content: breed.description ?? 'No information available.',
                  ),

                  _Section(
                    title: 'History',
                    content: breed.history ?? 'No information available.',
                  ),

                  _Measurements(breed: breed),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> _extractCharacteristics(String? temperament) {
  if (temperament == null || temperament.isEmpty) {
    return [];
  }

  return temperament
      .split(',')
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toList();
}

class _BreedImage extends StatelessWidget {
  final String? imageUrl;

  const _BreedImage({required this.imageUrl});

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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _CharacteristicRow extends StatelessWidget {
  final String label;
  final bool value;

  const _CharacteristicRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            value ? Icons.check_circle_outline : Icons.remove_circle_outline,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String content;

  const _Section({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(content, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _Measurements extends StatelessWidget {
  final Breed breed;

  const _Measurements({required this.breed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MeasurementCard(
            title: 'Weight',
            imperial: breed.weight.imperial,
            metric: breed.weight.metric,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _MeasurementCard(
            title: 'Height',
            imperial: breed.height.imperial,
            metric: breed.height.metric,
          ),
        ),
      ],
    );
  }
}

class _MeasurementCard extends StatelessWidget {
  final String title;
  final String imperial;
  final String metric;

  const _MeasurementCard({
    required this.title,
    required this.imperial,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Metric: $metric'),
            Text('Imperial: $imperial'),
          ],
        ),
      ),
    );
  }
}
