// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/todo/data/data_sources/todo_data_source.dart' as _i20;
import '../../features/todo/data/data_sources/todo_data_source_impl.dart'
    as _i23;
import '../../features/todo/data/repositories/todo_repository_impl.dart'
    as _i767;
import '../../features/todo/domain/repository/todo_repository.dart' as _i673;
import '../../features/todo/presentation/bloc/todo_bloc.dart' as _i453;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i20.TodoRemoteDataSource>(
        () => _i23.TodoRemoteDataSourceImpl());
    gh.lazySingleton<_i673.TodoRepository>(
        () => _i767.TodoRepositoryImpl(gh<_i20.TodoRemoteDataSource>()));
    gh.factory<_i453.TodoBloc>(
        () => _i453.TodoBloc(gh<_i673.TodoRepository>()));
    return this;
  }
}
