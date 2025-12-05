import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/todo_home/domain/entities/todo.dart';
import 'package:test_todo_app/modules/todo_home/domain/repositories/todo_repository.dart';

@injectable
class UpdateTodoUsecase {
  final TodoRepository repository;
  UpdateTodoUsecase({required this.repository});
  
  Future<Either<Failure, void>> call(Todo todo) async {
    return await repository.updateTodo(todo);
  }
}

