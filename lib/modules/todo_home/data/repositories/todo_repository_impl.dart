import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/todo_home/data/datasources/todo_remote_data_source.dart';
import 'package:test_todo_app/modules/todo_home/data/models/todo_model.dart';
import 'package:test_todo_app/modules/todo_home/domain/entities/todo.dart';
import 'package:test_todo_app/modules/todo_home/domain/repositories/todo_repository.dart';

@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  TodoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    try {
      final result = await remoteDataSource.addTodo(TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted,
      ));
      return result.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(Failure(
        message: 'Unexpected error: $e', title: 'Repository Error',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      final result = await remoteDataSource.deleteTodo(id);
      return result.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(Failure(
        message: 'Unexpected error: $e', title: 'Repository Error',
      ));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> fetchTodos() async{
    try {
      final result = await remoteDataSource.fetchTodos();
      return result.fold(
        (failure) => Left(failure),
        (todoModels) => Right(todoModels.map((model) => model as Todo).toList()),
      );
    } catch (e) {
      return Left(Failure(
        message: 'Unexpected error: $e', title: 'Repository Error',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) async {
    try {
      final result = await remoteDataSource.updateTodo(TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted,
      ));
      return result.fold(
        (failure) => Left(failure),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(Failure(
        message: 'Unexpected error: $e', title: 'Repository Error',
      ));
    }
  }    
  
  }