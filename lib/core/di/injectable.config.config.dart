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
import 'package:test_todo_app/modules/auth/data/datasources/user_auth_remort_data_sources_impl.dart'
    as _i651;
import 'package:test_todo_app/modules/auth/data/datasources/user_auth_remort_data_soutce.dart'
    as _i171;
import 'package:test_todo_app/modules/auth/data/repositories/auth_user_repositories_impl.dart'
    as _i906;
import 'package:test_todo_app/modules/auth/domain/repositories/auth_user_repositories.dart'
    as _i1033;
import 'package:test_todo_app/modules/auth/domain/usecases/current_user_usecase.dart'
    as _i129;
import 'package:test_todo_app/modules/auth/domain/usecases/login_user_usecase.dart'
    as _i680;
import 'package:test_todo_app/modules/auth/domain/usecases/signout_user_usecas.dart'
    as _i877;
import 'package:test_todo_app/modules/auth/domain/usecases/signup_user_usecase.dart'
    as _i125;
import 'package:test_todo_app/modules/auth/presentation/bloc/auth_bloc.dart'
    as _i1064;
import 'package:test_todo_app/modules/todo_home/data/datasources/todo_remote_data_source.dart'
    as _i105;
import 'package:test_todo_app/modules/todo_home/data/datasources/todo_remote_data_source_impl.dart'
    as _i853;
import 'package:test_todo_app/modules/todo_home/data/repositories/todo_repository_impl.dart'
    as _i866;
import 'package:test_todo_app/modules/todo_home/domain/repositories/todo_repository.dart'
    as _i506;
import 'package:test_todo_app/modules/todo_home/domain/usecases/add_todo_usecase.dart'
    as _i788;
import 'package:test_todo_app/modules/todo_home/domain/usecases/delete_todo_usecase.dart'
    as _i275;
import 'package:test_todo_app/modules/todo_home/domain/usecases/get_todo_usecase.dart'
    as _i221;
import 'package:test_todo_app/modules/todo_home/domain/usecases/update_todo_usecase.dart'
    as _i218;
import 'package:test_todo_app/modules/todo_home/presentation/bloc/todo_bloc.dart'
    as _i655;

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
    gh.factory<_i171.UserAuthRemoteDataSource>(
      () => _i651.UserAuthRemortDataSourcesImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i105.TodoRemoteDataSource>(
      () => _i853.TodoLocalDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i506.TodoRepository>(
      () => _i866.TodoRepositoryImpl(
        remoteDataSource: gh<_i105.TodoRemoteDataSource>(),
      ),
    );
    gh.factory<_i1033.AuthUserRepositories>(
      () => _i906.AuthUserRepositoriesImpl(
        remoteDataSource: gh<_i171.UserAuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i788.AddTodoUsecase>(
      () => _i788.AddTodoUsecase(repository: gh<_i506.TodoRepository>()),
    );
    gh.factory<_i275.DeleteTodoUsecase>(
      () => _i275.DeleteTodoUsecase(repository: gh<_i506.TodoRepository>()),
    );
    gh.factory<_i221.GetTodoUsecase>(
      () => _i221.GetTodoUsecase(repository: gh<_i506.TodoRepository>()),
    );
    gh.factory<_i218.UpdateTodoUsecase>(
      () => _i218.UpdateTodoUsecase(repository: gh<_i506.TodoRepository>()),
    );
    gh.factory<_i129.CurrentUserUsecase>(
      () => _i129.CurrentUserUsecase(
        authRepository: gh<_i1033.AuthUserRepositories>(),
      ),
    );
    gh.factory<_i680.LoginUserUsecase>(
      () => _i680.LoginUserUsecase(
        authRepository: gh<_i1033.AuthUserRepositories>(),
      ),
    );
    gh.factory<_i877.SignoutUserUsecas>(
      () => _i877.SignoutUserUsecas(
        authRepository: gh<_i1033.AuthUserRepositories>(),
      ),
    );
    gh.factory<_i125.SignupUserUsecase>(
      () => _i125.SignupUserUsecase(
        authRepository: gh<_i1033.AuthUserRepositories>(),
      ),
    );
    gh.factory<_i1064.AuthBloc>(
      () => _i1064.AuthBloc(
        loginUserUsecase: gh<_i680.LoginUserUsecase>(),
        signupUserUsecase: gh<_i125.SignupUserUsecase>(),
        currentUserUsecase: gh<_i129.CurrentUserUsecase>(),
        signoutUserUsecas: gh<_i877.SignoutUserUsecas>(),
      ),
    );
    gh.factory<_i655.TodoBloc>(
      () => _i655.TodoBloc(
        getTodoUsecase: gh<_i221.GetTodoUsecase>(),
        addTodoUsecase: gh<_i788.AddTodoUsecase>(),
        deleteTodoUsecase: gh<_i275.DeleteTodoUsecase>(),
        updateTodoUsecase: gh<_i218.UpdateTodoUsecase>(),
      ),
    );
    return this;
  }
}

class _$SupabaseModule extends _i520.SupabaseModule {}
