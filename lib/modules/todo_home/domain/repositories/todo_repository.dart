import 'package:dartz/dartz.dart';
import 'package:test_todo_app/modules/todo_home/domain/entities/todo.dart';
import 'package:test_todo_app/core/error/failure.dart';


abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> fetchTodos();
  Future<Either<Failure,void>> addTodo(Todo todo);  
  Future<Either<Failure,void>> updateTodo(Todo todo);
  Future<Either<Failure,void>> deleteTodo(String id);
}