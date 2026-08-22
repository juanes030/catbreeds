import 'package:flutter/material.dart';

class BreedsEmptyView extends StatelessWidget {
  final bool isSearching;

  const BreedsEmptyView({super.key, required this.isSearching});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(isSearching ? 'No breeds found.' : 'No breeds available.'),
    );
  }
}
