import 'package:flutter/material.dart';
import 'package:catbreeds/core/di/injection.dart';
import 'package:catbreeds/features/breeds/presentation/pages/breeds_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const CatBreedsApp());
}

class CatBreedsApp extends StatelessWidget {
  const CatBreedsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cat Breeds',
      theme: ThemeData(useMaterial3: true),
      home: const BreedsPage(),
    );
  }
}
