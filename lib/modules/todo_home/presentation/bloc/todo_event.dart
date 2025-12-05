part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class TodoFetchEvent extends TodoEvent {}

final class TodoFetchAll extends TodoEvent {}

final class TodoAdd extends TodoEvent {
  final Todo todo;
  TodoAdd({required this.todo});
}

final class TodoDelete extends TodoEvent {
  final String todoId;
  TodoDelete({required this.todoId});
}

final class TodoUpdate extends TodoEvent {
  final Todo todo;
  TodoUpdate({required this.todo});
}


