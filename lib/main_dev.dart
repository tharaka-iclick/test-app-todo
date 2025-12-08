import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_app/core/di/injectable.config.dart';
import 'package:test_todo_app/core/theme/fonts.dart';
import 'package:test_todo_app/modules/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_todo_app/modules/auth/presentation/pages/login_page.dart';
import 'package:test_todo_app/modules/todo_home/presentation/bloc/todo_bloc.dart';
import 'package:test_todo_app/modules/todo_home/presentation/pages/todo_home.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(AuthIsUserLoggedIn()),
        ),
        BlocProvider(
          create: (context) => sl<TodoBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            print('Auth state changed: $state');
            if (state is AuthSuccess) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'My Todo App',
                    style: TextStyle(
                      fontSize: FontSize.s20,
                      fontWeight: FontWight.bold,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                ),
                body: const TodoHome(),
              );
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}