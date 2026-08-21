import 'package:catbreeds/core/error/exceptions/api_exception.dart';
import 'package:catbreeds/core/error/exceptions/network_exception.dart';
import 'package:catbreeds/core/error/failures/failure.dart';
import 'package:catbreeds/features/breeds/data/datasources/breeds_remote_data_source.dart';
import 'package:catbreeds/features/breeds/domain/entities/breed.dart';
import 'package:catbreeds/features/breeds/domain/repositories/breeds_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BreedsRepository)
class BreedsRepositoryImpl implements BreedsRepository {
  final BreedsRemoteDataSource remoteDataSource;

  BreedsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Breed>> getBreeds({required int page, required int limit}) async {
    try {
      return await remoteDataSource.getBreeds(page: page, limit: limit);
    } on ApiException catch (e) {
      switch (e.statusCode) {
        case 401:
        case 403:
          throw UnauthorizedFailure(e.message);

        case 404:
          throw NotFoundFailure(e.message);

        default:
          throw ServerFailure(e.message);
      }
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    } catch (_) {
      throw const UnknownFailure();
    }
  }
}
