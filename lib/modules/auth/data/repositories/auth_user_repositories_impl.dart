import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/auth/data/datasources/user_auth_remort_data_soutce.dart';
import 'package:test_todo_app/modules/auth/domain/entities/auth_user_entities.dart';
import 'package:test_todo_app/modules/auth/domain/repositories/auth_user_repositories.dart';

@Injectable(as: AuthUserRepositories)
class AuthUserRepositoriesImpl implements AuthUserRepositories {
  final UserAuthRemoteDataSource remoteDataSource;

  AuthUserRepositoriesImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.signInWithEmailAndPassword(
        email,
        password,
      );
      return Right(user);
    } catch (e) {
      return Left(Failure(message: e.toString(), title: "Sign In Failed"));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final user = await remoteDataSource.signUpWithEmailAndPassword(
        email,
        password,
        name,
      );
      return Right(user);
    } catch (e) {
      return Left(Failure(message: e.toString(), title: "Sign Up Failed"));
    }
  }

  @override
  Future<void> signOut() async {
    return remoteDataSource.signOut();
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userSession = remoteDataSource.currentUserSession;
      if (userSession == null) {
        return Left(
          Failure(message: "No user logged in", title: "Get User Failed"),
        );
      }

      final user = await remoteDataSource.getCurrentUser();
      if (user == null) {
        return Left(
          Failure(message: "No user logged in", title: "Get User Failed"),
        );
      }
      return Right(user);
    } catch (e) {
      return Left(Failure(message: e.toString(), title: "Get User Failed"));
    }
  }
}
