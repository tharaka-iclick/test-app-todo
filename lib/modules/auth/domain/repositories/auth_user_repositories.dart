import 'package:dartz/dartz.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/auth/domain/entities/auth_user_entities.dart';

abstract interface class AuthUserRepositories {
  Future<Either<Failure, User>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  );
  Future<void> signOut();
  Future<Either<Failure, User>> getCurrentUser();
}
