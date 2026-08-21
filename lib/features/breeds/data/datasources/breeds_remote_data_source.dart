import 'package:catbreeds/features/breeds/data/models/breed_model.dart';

abstract class BreedsRemoteDataSource {
  Future<List<BreedModel>> getBreeds({required int page, required int limit});
}
