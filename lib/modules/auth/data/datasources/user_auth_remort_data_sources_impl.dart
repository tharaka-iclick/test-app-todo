import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_todo_app/modules/auth/data/datasources/user_auth_remort_data_soutce.dart';
import 'package:test_todo_app/modules/auth/data/models/auth_user_model.dart';

@Injectable(as: UserAuthRemoteDataSource)
class UserAuthRemortDataSourcesImpl implements UserAuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  UserAuthRemortDataSourcesImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final userDate = await supabaseClient
          .from('users')
          .select()
          .eq('id', currentUserSession!.user.id);

      return UserModel.fromJson(userDate.first).copyWith(
        email: currentUserSession!.user.email!,
      );
        } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      response.user == null ? throw Exception('User not found') : null;

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<void> signOut()async {
   try {
      await supabaseClient.auth.signOut(scope: SignOutScope.global);
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }

  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      response.user == null ? throw Exception('User not found') : null;

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
