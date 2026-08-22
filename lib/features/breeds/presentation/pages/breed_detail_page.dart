import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_characteristic_row.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_detail_image.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_detail_section.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_info_row.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_measurements.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_section_title.dart';
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
          BreedDetailImage(imageUrl: breed.image?.url),
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

                  BreedInfoRow(
                    label: 'Origin',
                    value: breed.origin ?? 'Unknown',
                  ),

                  BreedInfoRow(
                    label: 'Life span',
                    value: breed.lifeSpan ?? 'Unknown',
                  ),

                  const SizedBox(height: 24),

                  const BreedSectionTitle(title: 'Characteristics'),

                  const SizedBox(height: 12),

                  BreedCharacteristicRow(
                    label: 'Intelligence',
                    value: isIntelligent,
                  ),

                  BreedCharacteristicRow(
                    label: 'Adaptability',
                    value: isAdaptable,
                  ),

                  const SizedBox(height: 24),

                  BreedDetailSection(
                    title: 'Temperament',
                    content: breed.temperament ?? 'No information available.',
                  ),

                  BreedDetailSection(
                    title: 'Description',
                    content: breed.description ?? 'No information available.',
                  ),

                  BreedDetailSection(
                    title: 'History',
                    content: breed.history ?? 'No information available.',
                  ),

                  BreedMeasurements(breed: breed),
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
