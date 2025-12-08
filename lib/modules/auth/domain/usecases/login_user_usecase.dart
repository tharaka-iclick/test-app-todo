import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/auth/domain/entities/auth_user_entities.dart';
import 'package:test_todo_app/modules/auth/domain/repositories/auth_user_repositories.dart';

@injectable
class LoginUserUsecase {
  final AuthUserRepositories authRepository;
  LoginUserUsecase({required this.authRepository});
  
  Future<Either<Failure, User>> call(String email, String password) async {
    return await authRepository.signInWithEmailAndPassword(email, password);
  }
}