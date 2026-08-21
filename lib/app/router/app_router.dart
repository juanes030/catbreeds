import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:catbreeds/features/breeds/presentation/pages/breed_detail_page.dart';
import 'package:catbreeds/features/breeds/presentation/pages/breeds_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'breeds',
        builder: (context, state) {
          return const BreedsPage();
        },
      ),
      GoRoute(
        path: '/breed/:id',
        name: 'breed-detail',
        builder: (context, state) {
          final breed = state.extra as Breed;

          return BreedDetailPage(breed: breed);
        },
      ),
    ],
  );
}
