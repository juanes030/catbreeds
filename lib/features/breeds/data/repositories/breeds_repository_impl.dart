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
          throw const UnauthorizedFailure();

        case 404:
          throw const NotFoundFailure();

        default:
          throw const ServerFailure();
      }
    } on NetworkException {
      throw const NetworkFailure();
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<List<Breed>> searchBreeds({required String query}) async {
    try {
      return await remoteDataSource.searchBreeds(query: query);
    } on ApiException catch (e) {
      switch (e.statusCode) {
        case 401:
        case 403:
          throw const UnauthorizedFailure();

        case 404:
          throw const NotFoundFailure();

        default:
          throw const ServerFailure();
      }
    } on NetworkException {
      throw const NetworkFailure();
    } catch (_) {
      throw const UnknownFailure();
    }
  }
}
