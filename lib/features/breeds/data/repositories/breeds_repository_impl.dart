import 'package:catbreeds/features/breeds/data/datasources/breeds_remote_data_source.dart';
import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:catbreeds/features/breeds/domain/repositories/breeds_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BreedsRepository)
class BreedsRepositoryImpl implements BreedsRepository {
  final BreedsRemoteDataSource remoteDataSource;

  BreedsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Breed>> getBreeds({required int page, required int limit}) {
    return remoteDataSource.getBreeds(page: page, limit: limit);
  }
}
