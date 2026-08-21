import 'package:catbreeds/core/error/exceptions/api_exception.dart';
import 'package:catbreeds/core/error/exceptions/network_exception.dart';
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
    try {
      final response = await dio.get(
        '/breeds',
        queryParameters: {'page': page, 'limit': limit},
      );

      final data = response.data as List<dynamic>;

      return data
          .map((json) => BreedModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException(
          statusCode: e.response?.statusCode,
          message: e.message ?? 'API request failed.',
        );
      }

      throw NetworkException(
        e.message ?? 'Please check your internet connection.',
      );
    }
  }

  @override
  Future<List<BreedModel>> searchBreeds({required String query}) async {
    try {
      final response = await dio.get(
        '/breeds/search',
        queryParameters: {'q': query, 'attach_image': 1},
      );

      final data = response.data as List<dynamic>;

      return data
          .map((json) => BreedModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException(
          statusCode: e.response?.statusCode,
          message: e.message ?? 'API request failed.',
        );
      }

      throw NetworkException(
        e.message ?? 'Please check your internet connection.',
      );
    }
  }
}
