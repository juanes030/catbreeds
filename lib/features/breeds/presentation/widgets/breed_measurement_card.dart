import 'package:flutter/material.dart';

class BreedMeasurementCard extends StatelessWidget {
  final String title;
  final String imperial;
  final String metric;

  const BreedMeasurementCard({
    super.key,
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
