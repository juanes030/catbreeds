import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:catbreeds/features/breeds/domain/repositories/breeds_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBreeds {
  final BreedsRepository repository;

  GetBreeds(this.repository);

  Future<List<Breed>> call({required int page, required int limit}) {
    return repository.getBreeds(page: page, limit: limit);
  }
}
