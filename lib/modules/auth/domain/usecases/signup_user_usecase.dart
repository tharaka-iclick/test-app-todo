import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/auth/domain/entities/auth_user_entities.dart';
import 'package:test_todo_app/modules/auth/domain/repositories/auth_user_repositories.dart';

@injectable
class SignupUserUsecase {
  final AuthUserRepositories authRepository;
  SignupUserUsecase({required this.authRepository});

  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      params.email,
      params.password,
      params.name,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
