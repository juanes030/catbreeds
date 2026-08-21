import 'package:catbreeds/app/router/app_router.dart';
import 'package:catbreeds/core/di/injection.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(const CatBreedsApp());
}

class CatBreedsApp extends StatelessWidget {
  const CatBreedsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cat Breeds',
      theme: ThemeData(useMaterial3: true),
      routerConfig: AppRouter.router,
    );
  }
}
