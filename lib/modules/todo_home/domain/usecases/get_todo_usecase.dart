

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/todo_home/domain/entities/todo.dart';
import 'package:test_todo_app/modules/todo_home/domain/repositories/todo_repository.dart';

@injectable
class GetTodoUsecase {
  final TodoRepository repository;
  GetTodoUsecase({required this.repository});

  Future<Either<Failure, List<Todo>>> call(noParams) async{
    return await repository.fetchTodos();
  }
}