import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_todo_app/modules/auth/data/models/auth_user_model.dart';

abstract interface class UserAuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> signUpWithEmailAndPassword(String email, String password, String name);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}