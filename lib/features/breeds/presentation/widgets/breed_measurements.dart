import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:catbreeds/features/breeds/presentation/widgets/breed_measurement_card.dart';
import 'package:flutter/material.dart';

class BreedMeasurements extends StatelessWidget {
  final Breed breed;

  const BreedMeasurements({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BreedMeasurementCard(
            title: 'Weight',
            imperial: breed.weight.imperial,
            metric: breed.weight.metric,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: BreedMeasurementCard(
            title: 'Height',
            imperial: breed.height.imperial,
            metric: breed.height.metric,
          ),
        ),
      ],
    );
  }
}
