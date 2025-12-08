// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;
import 'package:test_todo_app/core/config/app_config.dart' as _i352;
import 'package:test_todo_app/core/di/injectable.config.dart' as _i520;
import 'package:test_todo_app/modules/todo_home/data/datasources/todo_remote_data_source.dart'
    as _i105;
import 'package:test_todo_app/modules/todo_home/data/datasources/todo_remote_data_source_impl.dart'
    as _i853;
import 'package:test_todo_app/modules/todo_home/data/repositories/todo_repository_impl.dart'
    as _i866;
import 'package:test_todo_app/modules/todo_home/domain/repositories/todo_repository.dart'
    as _i506;

const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final supabaseModule = _$SupabaseModule();
    gh.singleton<_i454.SupabaseClient>(() => supabaseModule.client);
    gh.singleton<_i352.AppConfig>(
      () => _i352.ProdAppConfig(),
      registerFor: {_dev},
    );
    gh.factory<_i105.TodoRemoteDataSource>(
      () => _i853.TodoLocalDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i506.TodoRepository>(
      () => _i866.TodoRepositoryImpl(
        remoteDataSource: gh<_i105.TodoRemoteDataSource>(),
      ),
    );
    return this;
  }
}

class _$SupabaseModule extends _i520.SupabaseModule {}
