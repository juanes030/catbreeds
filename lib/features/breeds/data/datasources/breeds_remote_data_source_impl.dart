import 'package:catbreeds/features/breeds/data/datasources/breeds_remote_data_source.dart';
import 'package:catbreeds/features/breeds/data/models/breed_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BreedsRemoteDataSource)
class BreedsRemoteDataSourceImpl implements BreedsRemoteDataSource {
  final Dio dio;

  BreedsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BreedModel>> getBreeds({
    required int page,
    required int limit,
  }) async {
    final response = await dio.get(
      '/breeds',
      queryParameters: {'page': page, 'limit': limit},
    );

    final data = response.data as List<dynamic>;

    return data
        .map((json) => BreedModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
