import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/auth/domain/entities/auth_user_entities.dart';
import 'package:test_todo_app/modules/auth/domain/repositories/auth_user_repositories.dart';

@injectable
class CurrentUserUsecase {
  final AuthUserRepositories authRepository;
  CurrentUserUsecase({required this.authRepository});

  Future<Either<Failure, User>> call() async {
    return await authRepository.getCurrentUser();
  }
}