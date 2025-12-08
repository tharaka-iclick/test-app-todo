import 'package:injectable/injectable.dart';
import 'package:test_todo_app/modules/auth/domain/repositories/auth_user_repositories.dart';

@injectable
class SignoutUserUsecas {
  final AuthUserRepositories authRepository;
  SignoutUserUsecas({required this.authRepository});

  Future<void> call() async {
    return await authRepository.signOut();
  }
}
