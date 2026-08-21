import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:catbreeds/features/breeds/domain/repositories/breeds_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchBreeds {
  final BreedsRepository repository;

  SearchBreeds(this.repository);

  Future<List<Breed>> call({required String query}) {
    return repository.searchBreeds(query: query);
  }
}
