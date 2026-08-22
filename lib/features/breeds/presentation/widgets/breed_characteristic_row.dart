import 'package:flutter/material.dart';

class BreedCharacteristicRow extends StatelessWidget {
  final String label;
  final bool value;

  const BreedCharacteristicRow({
    super.key,
    required this.label,
    required this.value,
  });

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
