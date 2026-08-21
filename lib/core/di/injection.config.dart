// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:catbreeds/core/network/dio_config.dart' as _i624;
import 'package:catbreeds/features/breeds/data/datasources/breeds_remote_data_source.dart'
    as _i646;
import 'package:catbreeds/features/breeds/data/datasources/breeds_remote_data_source_impl.dart'
    as _i392;
import 'package:catbreeds/features/breeds/data/repositories/breeds_repository_impl.dart'
    as _i847;
import 'package:catbreeds/features/breeds/domain/repositories/breeds_repository.dart'
    as _i393;
import 'package:catbreeds/features/breeds/domain/usecases/get_breeds.dart'
    as _i300;
import 'package:catbreeds/features/breeds/domain/usecases/search_breeds.dart'
    as _i974;
import 'package:catbreeds/features/breeds/presentation/bloc/breeds/breeds_bloc.dart'
    as _i1070;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i646.BreedsRemoteDataSource>(
      () => _i392.BreedsRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i393.BreedsRepository>(
      () => _i847.BreedsRepositoryImpl(gh<_i646.BreedsRemoteDataSource>()),
    );
    gh.factory<_i300.GetBreeds>(
      () => _i300.GetBreeds(gh<_i393.BreedsRepository>()),
    );
    gh.factory<_i974.SearchBreeds>(
      () => _i974.SearchBreeds(gh<_i393.BreedsRepository>()),
    );
    gh.factory<_i1070.BreedsBloc>(
      () => _i1070.BreedsBloc(gh<_i300.GetBreeds>(), gh<_i974.SearchBreeds>()),
    );
    return this;
  }
}

class _$DioModule extends _i624.DioModule {}
