import 'package:catbreeds/core/constants/env.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: 'https://api.thecatapi.com/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json', 'x-api-key': Env.catApiKey},
    ),
  );
}
