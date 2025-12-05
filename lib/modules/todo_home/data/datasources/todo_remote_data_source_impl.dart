import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_todo_app/core/error/failure.dart';
import 'package:test_todo_app/modules/todo_home/data/datasources/todo_remote_data_source.dart';
import 'package:test_todo_app/modules/todo_home/data/models/todo_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: TodoRemoteDataSource)
class TodoLocalDataSourceImpl implements TodoRemoteDataSource {
    final SupabaseClient _supabase;
  const TodoLocalDataSourceImpl(this._supabase);

  @override
  Future<Either<Failure, void>> addTodo(TodoModel todo) async {
    try {
      final todoJson = todo.toJson();
      todoJson.remove('id');
      
      await _supabase.from('todos').insert(todoJson);
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(Failure(
        message: 'failed to add: ${e.message}', title: 'Error',
      ));
    } catch (e) {
      return Left(Failure(
        message: 'Unexpected error: $e', title: 'Supabase Error',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      final idValue = int.tryParse(id) ?? id;
      await _supabase
          .from('todos')
          .delete()
          .eq('id', idValue);
      
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(Failure(
        message: 'failed to delete: ${e.message}',
         title: 'Error',
      ));
    } catch (e) {
      return Left(Failure(
        message: 'Unexpected error: $e', title: 'Supabase Error',
      ));
    }
  }

  @override
  Future<Either<Failure, List<TodoModel>>> fetchTodos() async {
    try {
      final response = await _supabase
          .from('todos')
          .select();

      final todos = (response as List)
          .map((json) => TodoModel.fromJson(json))
          .toList();

      return Right(todos);
    } on PostgrestException catch (e) {
       return Left(
            Failure(message: 'failed to fetch: ${e.message}', title: 'Error',),
          );
    } catch (e) {
      return Left(Failure(
        message: 'Unexpected error: $e', title: 'Supabase Error',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(TodoModel todo) async {
    try {

      final updateData = todo.toJson();
      final idValue = int.tryParse(todo.id) ?? todo.id;
      updateData.remove('id');
      
      await _supabase
          .from('todos')
          .update(updateData)
          .eq('id', idValue);
      
      return const Right(null);
    } on PostgrestException catch (e) {
      return Left(Failure(
        message: 'failed to update: ${e.message}',title: 'Error',
      ));
    } catch (e) {
      return Left(Failure(
        message: 'Unexpected error: $e', title: 'Supabase Error',
      ));
    }
  }
  
}