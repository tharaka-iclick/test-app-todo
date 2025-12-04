
import 'package:dartz/dartz.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/todo_home/data/models/todo_model.dart';

abstract interface class TodoRemoteDataSource {
  Future<Either<Failure, List<TodoModel>>> fetchTodos();
  Future<Either<Failure,void>> addTodo(TodoModel todo);  
  Future<Either<Failure,void>> updateTodo(TodoModel todo);
  Future<Either<Failure,void>> deleteTodo(String id);
}