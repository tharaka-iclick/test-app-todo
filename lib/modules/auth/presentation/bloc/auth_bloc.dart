import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_todo_app/modules/auth/domain/entities/auth_user_entities.dart';
import 'package:test_todo_app/modules/auth/domain/usecases/login_user_usecase.dart';
import 'package:test_todo_app/modules/auth/domain/usecases/signup_user_usecase.dart';
import 'package:test_todo_app/modules/auth/domain/usecases/current_user_usecase.dart';
import 'package:test_todo_app/modules/auth/domain/usecases/signout_user_usecas.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUserUsecase loginUserUsecase;
  final SignupUserUsecase signupUserUsecase;
  final CurrentUserUsecase currentUserUsecase;
  final SignoutUserUsecas signoutUserUsecas;

  AuthBloc({
    required this.loginUserUsecase,
    required this.signupUserUsecase,
    required this.currentUserUsecase,
    required this.signoutUserUsecas,
  }) : super(AuthInitial()) {
    on<AuthLogin>(_onAuthLogin);
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
    on<AuthLogout>(_onAuthSignOut);
  }

  Future<void> _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await loginUserUsecase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await signupUserUsecase(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onAuthIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await currentUserUsecase();
    result.fold(
      (failure) => emit(AuthInitial()),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onAuthSignOut(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await signoutUserUsecas.call();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure('Failed to logout: $e'));
    }
  }
}


