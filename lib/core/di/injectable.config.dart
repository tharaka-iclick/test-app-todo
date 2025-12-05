import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:test_todo_app/core/di/injectable.config.config.dart';
import 'package:test_todo_app/core/enum/app_enum.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies({required AppEnv env}) async {
  final envFilePath = 'env/.env.${env.name}';
  await dotenv.load(fileName: envFilePath);

  sl.init(environment: env.name);
}

@module
abstract class SupabaseModule {
  @singleton
  SupabaseClient get client  {
    final url = dotenv.get('API_URL');
    final anonKey = dotenv.get('ANON_KEY');

    Supabase.initialize(url: url, anonKey: anonKey);
    return Supabase.instance.client;
  }
}

