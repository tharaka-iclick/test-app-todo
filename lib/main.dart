import 'package:flutter/material.dart';
import 'package:test_todo_app/core/di/injectable.config.dart';
import 'package:test_todo_app/core/enum/app_enum.dart';
import 'package:test_todo_app/main_dev.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env: AppEnv.dev);
  
  runApp(const MyApp());
}
