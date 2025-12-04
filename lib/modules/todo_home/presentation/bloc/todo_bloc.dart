import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/todo_home/domain/entities/todo.dart';
import 'package:test_todo_app/modules/todo_home/domain/usecases/add_todo_usecase.dart';
import 'package:test_todo_app/modules/todo_home/domain/usecases/delete_todo_usecase.dart';
import 'package:test_todo_app/modules/todo_home/domain/usecases/get_todo_usecase.dart';
import 'package:test_todo_app/modules/todo_home/domain/usecases/update_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

@injectable
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodoUsecase _getTodoUsecase;
  final AddTodoUsecase _addTodoUsecase;
  final DeleteTodoUsecase _deleteTodoUsecase;
  final UpdateTodoUsecase _updateTodoUsecase;

  TodoBloc({
    required GetTodoUsecase getTodoUsecase,
    required AddTodoUsecase addTodoUsecase,
    required DeleteTodoUsecase deleteTodoUsecase,
    required UpdateTodoUsecase updateTodoUsecase,
  }) : _addTodoUsecase = addTodoUsecase,
       _getTodoUsecase = getTodoUsecase,
       _deleteTodoUsecase = deleteTodoUsecase,
       _updateTodoUsecase = updateTodoUsecase,
       super(TodoInitial()) {
    on<TodoFetchAll>(_onTodoFetchAll);
    on<TodoAdd>(_onTodoAdd);
    on<TodoDelete>(_onTodoDelete);
    on<TodoUpdate>(_onTodoUpdate);
  }

  Future<void> _onTodoFetchAll(
    TodoFetchAll event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final result = await _getTodoUsecase.call(null);

    result.fold(
      (failure) => emit(TodoFailure(failure: failure)),
      (todos) => emit(TodoSucces(todos: todos)),
    );
  }

  Future<void> _onTodoAdd(TodoAdd event, Emitter<TodoState> emit) async {
    final result = await _addTodoUsecase.call(event.todo);

    result.fold(
      (failure) => emit(TodoFailure(failure: failure)),
      (r) => add(TodoFetchAll()),
    );
  }

  Future<void> _onTodoDelete(TodoDelete event, Emitter<TodoState> emit) async {
    final result = await _deleteTodoUsecase.call(event.todoId);

    result.fold(
      (failure) => emit(TodoFailure(failure: failure)),
      (r) => add(TodoFetchAll()),
    );
  }

  Future<void> _onTodoUpdate(TodoUpdate event, Emitter<TodoState> emit) async {
    final result = await _updateTodoUsecase.call(event.todo);

    result.fold(
      (failure) => emit(TodoFailure(failure: failure)),
      (r) => add(TodoFetchAll()),
    );
  }
}
