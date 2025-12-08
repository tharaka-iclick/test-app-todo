part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoSucces extends TodoState {
  final List<Todo> todos;
  TodoSucces({required this.todos});
}

final class TodoFailure extends TodoState {
  final Failure failure;
  TodoFailure({required this.failure});
}
