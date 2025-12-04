import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

abstract class AppConfig {
  String get apiUrl;
  String get anonKey;
}

@Singleton(as: AppConfig, env: ['dev'])
class ProdAppConfig implements AppConfig {
  @override
  String get apiUrl => dotenv.env['API_URL'] ?? '';

  @override
  String get anonKey => dotenv.env['ANON_KEY'] ?? '';
}