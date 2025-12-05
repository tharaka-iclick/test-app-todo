import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_app/core/di/injectable.config.dart';
import 'package:test_todo_app/core/theme/fonts.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => sl<TodoBloc>(),
        child: Scaffold(
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
        ),
      ),
    );
  }
}